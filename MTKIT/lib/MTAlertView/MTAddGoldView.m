//
//  MTAddGoldView.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/4/11.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "MTAddGoldView.h"
#import "MTRETool.h"
@interface MTAddGoldView()<UITextFieldDelegate>

@property (nonatomic, weak) UIView *showView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *reduceBtn;
@property (nonatomic, weak) UIButton *addBtn;
@property (nonatomic, weak) UITextField *contentView;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, assign) NSInteger GoldNum;
@property (nonatomic, assign) MTGoldType type;


@property (nonatomic, weak) UIButton *cancleBtn;
@property (nonatomic, weak) UIButton *sureBtn;
@end

@implementation MTAddGoldView

- (instancetype)initWithChangeGoldNum:(NSInteger)GoldNum type:(MTGoldType)type{
    self = [super init];
    if (self) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
        [self setupSubViewstype:type];
        [self setupLayoutstype:type];
        self.GoldNum = GoldNum;
        self.type = type;
    }
    return self;
}

- (void)show {

    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)setupSubViewstype:(MTGoldType)type{

    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [UIColor colorWithHexStr:@"#000000" alpha:0.5];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBoard)]];

    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = [UIColor whiteColor];
    [showView layer].cornerRadius = 5;
    showView.userInteractionEnabled = YES;
    showView.layer.masksToBounds = YES;
    _showView = showView;
    [self addSubview:_showView];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"输入悬赏金额:";
    [titleLabel setTextColor:[UIColor colorWithHexStr:Gray_Color alpha:1]];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel = titleLabel;
    [_showView addSubview:_titleLabel];

    UIButton *reduceBtn = [[UIButton alloc] init];
    reduceBtn.layer.borderWidth = 1;
    reduceBtn.layer.borderColor = [UIColor colorWithHexStr:@"#E5E5E5" alpha:1].CGColor;
    [reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reduceBtn.userInteractionEnabled = YES;
    [reduceBtn setImage:[UIImage imageNamed:@"icon_reduce_lose"] forState:UIControlStateNormal];
    [reduceBtn addTarget:self action:@selector(reduceAction:) forControlEvents:UIControlEventTouchUpInside];
    [reduceBtn.titleLabel setFont:SYSFONT12];
    _reduceBtn = reduceBtn;
    [_showView addSubview:_reduceBtn];

    UIButton *addBtn = [[UIButton alloc] init];
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor = [UIColor colorWithHexStr:@"#E5E5E5" alpha:1].CGColor;
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.userInteractionEnabled = YES;
    [addBtn setImage:[UIImage imageNamed:@"askadd"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn.titleLabel setFont:SYSFONT12];
    _addBtn = addBtn;
    [_showView addSubview:_addBtn];

    UITextField *contentView = [[UITextField alloc] init];
    contentView.text = @"0";
    contentView.delegate = self;
    contentView.layer.borderWidth = 1;
    contentView.layer.borderColor = [UIColor colorWithHexStr:@"#E5E5E5" alpha:1].CGColor;
    contentView.userInteractionEnabled = YES;
    contentView.keyboardType = UIKeyboardTypeNumberPad;
    contentView.textAlignment = NSTextAlignmentCenter;
    _contentView = contentView;
    [_showView addSubview:_contentView];

    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [contentLabel setText:@"你目前的麦币为："];
    [contentLabel setTextColor:[UIColor colorWithHexStr:Gray_Color alpha:1]];
    _contentLabel = contentLabel;
    [_showView addSubview:_contentLabel];

    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [textLabel setText:MTToast_PT_AddGold];
    textLabel.numberOfLines = 0;
    [textLabel setTextColor:[UIColor colorWithHexStr:Gray_Color alpha:1]];
    _textLabel = textLabel;
    [_showView addSubview:_textLabel];

    if (type == MTGoldNormal) {
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleBtn.backgroundColor = [UIColor colorWithHexStr:@"#F3F3F3" alpha:1];
        cancleBtn.userInteractionEnabled = YES;
//        [cancleBtn layer].cornerRadius = 3;
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:[UIColor colorWithHexStr:@"#333333" alpha:1.0f] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(alertcancleClick) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn = cancleBtn;
        [_showView addSubview:_cancleBtn];

        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.backgroundColor = [UIColor colorWithHexStr:@"#0076DA" alpha:1];
        sureBtn.userInteractionEnabled = YES;
//        [sureBtn layer].cornerRadius = 3;
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(alertSureBtnClk) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn = sureBtn;
        [_showView addSubview:_sureBtn];
    }
}

- (void)setupLayoutstype:(MTGoldType)type{

//    CGFloat paddingF = (ScreenWidth*0.5-81)*0.6;

    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(ScreenHeight/3);
        make.left.equalTo(self.mas_left).offset(MAX_PADDING);
        make.right.equalTo(self.mas_right).offset(-MAX_PADDING);
        if (iPhone5) {
            make.bottom.equalTo(self.mas_bottom).offset(-ScreenHeight/4);
        }else{
            make.bottom.equalTo(self.mas_bottom).offset(-ScreenHeight/3);
        }
    }];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_showView.mas_left).offset(MAX_PADDING);
        make.top.equalTo(_showView.mas_top).offset(MAX_PADDING);
    }];
    [_reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_top).offset(MAX_PADDING*3);
        make.left.equalTo(_titleLabel.mas_left).offset(ZERO_PADDING);
        make.width.offset(40);
        make.height.offset(40);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_reduceBtn.mas_right).offset(ZERO_PADDING);
        make.top.equalTo(_reduceBtn.mas_top).offset(ZERO_PADDING);
        make.width.offset(ScreenWidth-MAX_PADDING*2-100);
        make.height.offset(40);
    }];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_reduceBtn.mas_top).offset(ZERO_PADDING);
        make.left.equalTo(_contentView.mas_right).offset(ZERO_PADDING);
        make.width.offset(40);
        make.height.offset(40);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_reduceBtn.mas_bottom).offset(MAX_PADDING*2);
        make.width.offset(ScreenWidth - 2*MAX_PADDING);
    }];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).offset(MAX_PADDING*2);
        make.left.equalTo(_titleLabel.mas_left).offset(ZERO_PADDING);
        make.width.offset(ScreenWidth - 3*MAX_PADDING);
    }];

    if (type == MTGoldNormal) {
        [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_showView.mas_bottom).offset(0);
            make.left.equalTo(_showView.mas_left).offset(0);
            make.width.offset(self.width/2);
            make.height.offset(40);
        }];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_showView.mas_bottom).offset(0);
            make.right.equalTo(_showView.mas_right).offset(0);
            make.width.offset(self.width/2);
            make.height.offset(40);
        }];
    }

}

- (void)setGoldNum:(NSInteger)GoldNum{
    _GoldNum = GoldNum;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *baseString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"你目前的麦币为："] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexStr:Gray_Color alpha:1]}];
    NSMutableAttributedString *appString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %ld ",GoldNum] attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];

    [string appendAttributedString:baseString];
    [string appendAttributedString:appString];
    [_contentLabel setAttributedText:string];
}
#pragma mark -减少悬赏值
- (void)reduceAction:(UIButton *)sender{
    if (self.reduceBtnAction) {
        NSInteger goldNum = [_contentView.text integerValue];
        NSInteger goldTemp = goldNum - 1;
        if (goldTemp <= 0) {
            goldTemp = 0;
        }
        [_contentView setText:[NSString stringWithFormat:@"%ld",goldTemp]];
        self.addOfferVal = [_contentView.text integerValue];
        NSLog(@"%ld",self.addOfferVal);
        self.reduceBtnAction();
    }

}
#pragma mark -增加悬赏值
- (void)addAction:(UIButton *)sender{
    if (self.addBtnAction) {
        NSInteger goldNum = [_contentView.text integerValue];
        NSInteger goldTemp = goldNum + 1;
        if (goldTemp > self.GoldNum) {
            [[Toast shareToast] makeText:MTToast_PT_MaxGold aDuration:1];
//            goldTemp = self.GoldNum;
        }
        [_contentView setText:[NSString stringWithFormat:@"%ld",goldTemp]];
        self.addOfferVal = [_contentView.text integerValue];
        NSLog(@"%ld",self.addOfferVal);
        self.addBtnAction();
    }
}
- (void)alertcancleClick{
    if (self.cancleBtnAction) {
        self.cancleBtnAction();
        [self removeMTAlertView];
    }
}

- (void)alertSureBtnClk{
    if (self.sureBtnAction) {
        self.sureBtnAction();
        [self removeMTAlertView];
    }
}

- (void)removeMTAlertView{
    [self removeFromSuperview];
}

- (BOOL)textFieldDidChange:(UITextField *)textField {
    if (_contentView.text.length>=8) {
        NSRange rangeStr = NSMakeRange(0, 8);
        _contentView.text = [_contentView.text substringWithRange:rangeStr];
    }
    self.addOfferVal = [_contentView.text integerValue];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text integerValue] == 0) {
        textField.text = @"";
    }
}



- (void)hiddenKeyBoard{
    [MTTools_MM keyboardRetracting];
}

- (void)setAddOfferVal:(NSInteger)addOfferVal{
    _addOfferVal = addOfferVal;
    UIImage *addImage = [UIImage imageNamed:@"askadd"];
    UIImage *reduceImage = [UIImage imageNamed:@"askBg"];
    if (_addOfferVal == 0) {
        _reduceBtn.userInteractionEnabled = NO;
        [_reduceBtn setImage:[UIImage imageNamed:@"icon_reduce_lose"] forState:UIControlStateNormal];
    }else{
        _reduceBtn.userInteractionEnabled = YES;
        [_reduceBtn setImage:reduceImage forState:UIControlStateNormal];
    }

    if (_addOfferVal >= _GoldNum) {
        _addBtn.userInteractionEnabled = NO;
        [_addBtn setImage:[UIImage imageNamed:@"icon_plus_lose"] forState:UIControlStateNormal];
    }else{
        _addBtn.userInteractionEnabled = YES;
        [_addBtn setImage:addImage forState:UIControlStateNormal];
    }

    NSLog(@"%ld---",self.addOfferVal);
    [MTInfoSingle shareInstance].addOfferVal = _addOfferVal;
}

@end
