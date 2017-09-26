//
//  MTPopMenu.m
//  PopMenu
//
//  Created by 鲁志刚 on 2017/3/16.
//  Copyright © 2017年 FEBA. All rights reserved.
//

#import "MTPopMenu.h"
@class MTPopMenuCell;

#define OriginY(obj) obj.frame.origin.y
#define OriginX(obj) obj.frame.origin.x
#define Height(obj)  obj.frame.size.height

@interface MTPopMenu () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *images;
@property (nonatomic, strong) UITableView *mainTable;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic,weak) UIView *sender;
@property (nonatomic,weak) UIView *superView;
@property (nonatomic,weak) CAShapeLayerWithStartPoint *bgShapeLayer;

@property (nonatomic,copy) void (^selectedIndex)(NSUInteger index);

@property (nonatomic, strong) UIColor *selectedCellBackgroudColor;

@property (nonatomic, assign) BOOL canTapClick;

@end

@implementation MTPopMenu

#pragma mark 构造MTPopMenu
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithTitles:nil images:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithTitles:nil images:nil];
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles images:(NSArray<NSString *> *)images {
    if (self = [super initWithFrame:CGRectZero]) {
        self.titles = titles;
        self.images = images;
        [self _setup];
        self.frame = [UIScreen mainScreen].bounds;
        self.showArrow = true;
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)_setup
{
    self.canTapClick = YES;
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(dismissPopView) forControlEvents:UIControlEventTouchUpInside];
    _cancelButton = cancelButton;
    
    [self setPopMenuBackgroundColor:HEXCOLOR(0x0076DA)];
    [self setPopMenuTitleColor:[UIColor whiteColor]];
    [self setSelectedBackgroudColor:HEXCOLOR(0x1983dd)];
    
    [self addSubview:self.mainTable];
}

- (void)popViewForSender:(UIView *)sender inView:(UIView *)view selectedIndex:(void (^)(NSUInteger))selectedIndex
{
    if (view && sender) {
        
        [view addSubview:self];
        
        MTPopMenu *popView = self;
        popView.selectedIndex = selectedIndex;
        popView.sender = sender;
        popView.superView = view;
        popView.backgroundColor = [UIColor clearColor];
        
        popView.alpha = 1.0;
        [view addSubview:popView];
        [UIView animateWithDuration:0.3 animations:^{
            popView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
        
        CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.fromValue = [NSNumber numberWithFloat:1.005];
        animation.toValue = [NSNumber numberWithFloat:1.0];
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        anim.fromValue = [NSNumber numberWithFloat:0.79];
        anim.toValue = [NSNumber numberWithFloat:1.0];
        
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup new];
        animationGroup.duration = 0.3f;
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animationGroup.animations = @[animation,anim];
        [popView.bgShapeLayer addAnimation:animationGroup forKey:nil];
    }
    
    CGRect convertRect = [self.sender.superview convertRect:self.sender.frame toView:self];
    
    if (self.sender) {
        CGRect frame = CGRectZero;
        frame.origin.y = CGRectGetMaxY(convertRect);
        if ([self.superview isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
            frame.origin.y = 64;
        }
        frame.size.width = 10;
        frame.size.height = MTPOPMENU_ROW_HEIGHT*self.titles.count;
        frame.origin.x = self.frame.size.width - frame.size.width;
        
        self.mainTable.frame = frame;
    }
    
    [self.mainTable reloadData];
}

- (void)tapGes:(UITapGestureRecognizer *)tapGes
{
    [self dismissPopView];
}

- (void)dismissPopView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        _canTapClick = YES;
    }];
}

- (void)setPopMenuBackgroundColor:(UIColor *)color
{
    self.mainTable.backgroundColor = color;
    self.bgShapeLayer.fillColor = color.CGColor;
}

- (void)setPopMenuTitleColor:(UIColor *)color
{
    self.titleColor = color;
    [self.mainTable reloadData];
}

- (void)setSelectedBackgroudColor:(UIColor *)color
{
    self.selectedCellBackgroudColor = color;
    [self.mainTable reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.cancelButton.frame = self.bounds;

    CGRect convertRect = [self.sender.superview convertRect:self.sender.frame toView:self];
    
    if (self.sender) {
        CGRect frame = self.mainTable.frame;
        frame.origin.y = CGRectGetMaxY(convertRect);
        if ([self.superview isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
            frame.origin.y = 64;
        }
//        frame.size.width = 150;
//        frame.size.height = MTPOPMENU_ROW_HEIGHT*self.titles.count;
        frame.origin.x = self.frame.size.width - frame.size.width;
        
        self.mainTable.frame = frame;
    }
    
    UIBezierPath *path = [UIBezierPath new];
    CGFloat arrowW = 17;
    CGFloat arrowH = 10;
    
    CGFloat startX = CGRectGetMaxX(convertRect) - convertRect.size.width*0.5;
    CGFloat point2X = startX+arrowW*0.5;
    CGFloat point3X = CGRectGetMaxX(self.mainTable.frame);
    CGFloat point4X = self.mainTable.frame.origin.x;
    CGFloat radius = 2;
    CGPoint startPoint = CGPointMake(startX, CGRectGetMinY(self.mainTable.frame)-arrowH);
    
    self.mainTable.layer.cornerRadius = radius;
    self.mainTable.layer.masksToBounds = true;
    
    self.bgShapeLayer.startPoint = startPoint;
    [path moveToPoint:startPoint];
    [path addLineToPoint:CGPointMake(point2X, OriginY(self.mainTable))];
    [path addLineToPoint:CGPointMake(point3X-radius, OriginY(self.mainTable))];
    [path addArcWithCenter:CGPointMake(point3X-radius, OriginY(self.mainTable)+radius) radius:radius startAngle:M_PI*1.5 endAngle:0 clockwise:true];
    [path addLineToPoint:CGPointMake(point3X, OriginY(self.mainTable)+Height(self.mainTable))];
    [path addArcWithCenter:CGPointMake(point3X-radius, OriginY(self.mainTable)+Height(self.mainTable)-radius) radius:radius startAngle:0 endAngle:M_PI*0.5 clockwise:true];
    [path addLineToPoint:CGPointMake(point4X+radius, OriginY(self.mainTable)+Height(self.mainTable))];
    [path addArcWithCenter:CGPointMake(point4X+radius, OriginY(self.mainTable)+Height(self.mainTable)-radius) radius:radius startAngle:M_PI*0.5 endAngle:M_PI clockwise:true];
    [path addLineToPoint:CGPointMake(point4X, OriginY(self.mainTable))];
    [path addArcWithCenter:CGPointMake(point4X+radius, OriginY(self.mainTable)+radius) radius:radius startAngle:M_PI endAngle:M_PI*1.5 clockwise:true];
    [path addLineToPoint:CGPointMake(startX-arrowW*0.5, OriginY(self.mainTable))];
    [path closePath];
    self.bgShapeLayer.path = path.CGPath;
}

#pragma mark TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

const CGFloat MTPOPMENU_ROW_HEIGHT = 44.0f;
const CGFloat MTPOPMENU_MARGIN = 15.0f;
const CGFloat MTPOPMENU_TITLE_MARGIN = 7.0f;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MTPOPMENU_ROW_HEIGHT;
}

- (__kindof UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    MTPopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MTPopMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.title = [[UILabel alloc] initWithFrame:CGRectZero];
        cell.title.font = [UIFont systemFontOfSize:17];
        cell.title.textColor = self.titleColor;
        cell.title.textAlignment = NSTextAlignmentCenter;
        cell.img = [[UIImageView alloc] initWithFrame:CGRectZero];
        cell.img.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:cell.title];
        [cell.contentView addSubview:cell.img];
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    NSString *title = [self modelForIndexPath:indexPath];
    cell.title.text = title;
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = self.selectedCellBackgroudColor;
    
    if (indexPath.row < self.images.count) {
        cell.img.image = [UIImage imageNamed:self.images[indexPath.row]];
    }
    
    const CGFloat imgWH = 16;

    cell.img.frame = CGRectZero;
    if (cell.img.image) {
        cell.img.frame = CGRectMake(MTPOPMENU_MARGIN, (MTPOPMENU_ROW_HEIGHT-imgWH)*0.5, imgWH, imgWH);
    }
    [cell.title sizeToFit];
    
    
    CGFloat tableFrameW = cell.title.size.width + MTPOPMENU_MARGIN*2 + imgWH + MTPOPMENU_TITLE_MARGIN;
    
    if (tableFrameW > self.mainTable.frame.size.width) {
        CGRect tableFrame = CGRectMake(self.mainTable.frame.origin.x, self.mainTable.frame.origin.y, tableFrameW, MTPOPMENU_ROW_HEIGHT*self.titles.count);
        
        if (CGRectEqualToRect(self.mainTable.frame, tableFrame) == false) {
            self.mainTable.frame = tableFrame;
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }
    }
    
    cell.title.frame = CGRectMake(CGRectGetMaxX(cell.img.frame)+MTPOPMENU_TITLE_MARGIN, 0, cell.title.size.width, MTPOPMENU_ROW_HEIGHT);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_canTapClick == NO) {
        return;
    }
    _canTapClick = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:true];
    });
    if (self.selectedIndex) {
        self.selectedIndex(indexPath.row);
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissPopView];
    });
}

#pragma mark TableView model
- (NSString *)modelForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.titles.count) {
        return self.titles[indexPath.row];
    }
    return nil;
}

#pragma mark setters
- (void)setShowArrow:(BOOL)showArrow
{
    _showArrow = showArrow;
    self.bgShapeLayer.hidden = !_showArrow;
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
        mainTable.tableFooterView = [UITableViewHeaderFooterView new];
        mainTable.scrollEnabled = false;
        mainTable.backgroundColor = [UIColor clearColor];
        mainTable.separatorColor = [UIColor clearColor];
        mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTable = mainTable;
    }
    return _mainTable;
}

- (CAShapeLayerWithStartPoint *)bgShapeLayer
{
    if (_bgShapeLayer == nil) {
        CAShapeLayerWithStartPoint *bgShapeLayer = [CAShapeLayerWithStartPoint layer];
        [self.layer insertSublayer:bgShapeLayer below:self.mainTable.layer];
        
        bgShapeLayer.lineWidth   = 1 / [UIScreen mainScreen].scale;
        bgShapeLayer.anchorPoint = CGPointMake(0, 0);
        bgShapeLayer.lineCap     = kCALineCapRound;
        bgShapeLayer.lineJoin    = kCALineJoinRound;
        bgShapeLayer.fillColor = [UIColor whiteColor].CGColor;

        _bgShapeLayer = bgShapeLayer;
    }
    return _bgShapeLayer;
}

@end

@implementation CAShapeLayerWithStartPoint

@end

@implementation MTPopMenuCell



@end
