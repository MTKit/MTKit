//
//  MTTableViewIndexView.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/8/9.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "MTTableViewIndexView.h"
#import "NSIndexPath+TableView.h"
#import "UIColor+Hexcolor.h"
#import <Masonry.h>
@interface MTTableViewIndexView () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSArray <NSString *> *tableDataSource;

@property (nonatomic,strong) UITableView *mainTable;

@property (nonatomic,strong) NSIndexPath *selectedPath;

@property (nonatomic,strong) MTTableViewIndexViewIndicator *indicator;

@end

@implementation MTTableViewIndexView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
        pan.delegate = self;
        [self.mainTable addGestureRecognizer:pan];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 0.1;
        longPress.delegate = self;
        [self.mainTable addGestureRecognizer:longPress];
        
        self.indicator = [[MTTableViewIndexViewIndicator alloc] initWithFrame:CGRectZero];
        [self addSubview:self.indicator];
        self.indicator.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}

#pragma mark panGes 
- (void)panGes:(UIPanGestureRecognizer *)ges {
    if (ges.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [ges locationInView:self.mainTable];
        if (CGRectContainsPoint(self.mainTable.bounds, point)) {
            NSIndexPath *inp = [self.mainTable indexPathForRowAtPoint:point];
            [self tableView:self.mainTable didSelectRowAtIndexPath:inp];
        }
    }
}

- (void)longPress:(UIPanGestureRecognizer *)ges {
    if (ges.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [ges locationInView:self.mainTable];
        if (CGRectContainsPoint(self.mainTable.bounds, point)) {
            NSIndexPath *inp = [self.mainTable indexPathForRowAtPoint:point];
            [self tableView:self.mainTable didSelectRowAtIndexPath:inp];
        }
    }
}

- (void)reloadData {
    self.selectedPath = nil;
    
    if ([self.tableView.delegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        NSArray *array = [self.tableView.delegate performSelector:@selector(sectionIndexTitlesForTableView:) withObject:self.tableView];
        self.tableDataSource = array;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [self.mainTable reloadData];
    
    [self.tableView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITableViewIndex")]) {
            obj.hidden = true;
            obj.alpha = 0.0f;
        }
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat mainTableHeight = self.tableDataSource.count * rowHeight;
    self.mainTable.frame = CGRectMake(0, self.frame.size.height*0.5-mainTableHeight*0.5, self.frame.size.width, mainTableHeight);
}

#pragma mark TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataSource.count;
}

const float rowHeight = 20;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    MTTableViewIndexViewLabel *mt_titleLabel = [cell.contentView viewWithTag:10001];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        mt_titleLabel = [[MTTableViewIndexViewLabel alloc] initWithFrame:CGRectZero];
        mt_titleLabel.tag = 10001;
        [cell.contentView addSubview:mt_titleLabel];
        mt_titleLabel.font = [UIFont systemFontOfSize:14];
        mt_titleLabel.textColor = HEXCOLOR(0x666666);
        [mt_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(rowHeight);
            make.centerX.centerY.mas_equalTo(0.0f);
        }];
        mt_titleLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *title = [self modelForIndexPath:indexPath];
    mt_titleLabel.text = [title uppercaseString];
    mt_titleLabel.selected = [self.selectedPath isSameIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedPath = indexPath;
    __block UITableViewCell *cell;
    [tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTTableViewIndexViewLabel *mt_titleLabel = [obj.contentView viewWithTag:10001];
        mt_titleLabel.selected = false;
        NSIndexPath *inp = [tableView indexPathForCell:obj];
        if ([inp isSameIndexPath:indexPath]) {
            cell = obj;
        }
    }];
    MTTableViewIndexViewLabel *mt_titleLabel = [cell.contentView viewWithTag:10001];
    mt_titleLabel.selected = true;
    
    self.indicator.hidden = false;
    CGRect frame = [tableView rectForRowAtIndexPath:indexPath];
    CGPoint point = [tableView convertPoint:frame.origin toView:self];
    CGFloat y = point.y + frame.size.height * 0.5 - kTableViewIndexViewIndicatorH*0.5;
    self.indicator.frame = CGRectMake(-kTableViewIndexViewIndicatorW-8, y, kTableViewIndexViewIndicatorW, kTableViewIndexViewIndicatorH);
    
    if ([self.tableView numberOfSections] > indexPath.row) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:false];
    }
    
    self.indicator.textLabel.text = mt_titleLabel.text;
}

#pragma mark TableView model
- (NSString *)modelForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.tableDataSource.count) {
        return self.tableDataSource[indexPath.row];
    }
    return nil;
}

#pragma mark getters
- (UITableView *)mainTable
{
    if (_mainTable == nil) {
        UITableView *mainTable = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        mainTable.delegate = self;
        mainTable.dataSource = self;
        mainTable.estimatedRowHeight = 100;
        mainTable.rowHeight = UITableViewAutomaticDimension;
        mainTable.scrollEnabled = false;
        mainTable.tableFooterView = [UITableViewHeaderFooterView new];
        [self addSubview:mainTable];
        mainTable.backgroundColor = [UIColor clearColor];
        mainTable.backgroundView.backgroundColor = [UIColor clearColor];
        mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTable = mainTable;
    }
    return _mainTable;
}

@end

@implementation MTTableViewIndexViewLabel

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        self.backgroundColor = HEXCOLOR(0x5CB8FE);
        self.textColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor clearColor];
        self.textColor = HEXCOLOR(0x666666);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.masksToBounds = true;
}

@end

@implementation MTTableViewIndexViewIndicator

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_index_indicator"]];
        [self addSubview:self.imgView];
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgView.frame = self.bounds;
    self.textLabel.frame = CGRectMake(0, -0.5, 30, self.frame.size.height);
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideSelf) object:nil];
    if (hidden == false) {
        [self performSelector:@selector(hideSelf) withObject:nil afterDelay:0.5];
        self.alpha = 1.0;
    }
}

- (void)hideSelf {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    }];
}

@end

