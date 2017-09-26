//
//  MTAlertView.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/3/31.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "MTAlertView.h"
#import "UIColor+KNColor.h"
#import "MTMacro.h"
#import "Masonry.h"
@interface MTAlertView()

@property (nonatomic, weak) UIView *baseView;
@property (nonatomic, weak) UIView *showView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *subTitleLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIButton *cancleBtn;
@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation MTAlertView

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content cancleTitle:(NSString *)cancleTitle sureTitle:(NSString *)sureTitle{
    self = [super init];
    if (self) {
        [self setupSubViewsTitle:title content:content cancleTitle:cancleTitle sureTitle:sureTitle];
        if (!title) {
            title = @"";
        }
        if (!content) {
            title = @"";
        }
        if (!cancleTitle) {
            title = @"";
        }
        if (!sureTitle) {
            title = @"";
        }
        [self setupLayout];
    }
    return self;
}

- (void)show {

    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)setupSubViewsTitle:(NSString *)title content:(NSString *)content cancleTitle:(NSString *)cancleTitle sureTitle:(NSString *)sureTitle{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    UIView *baseView = [[UIView alloc] init];
    baseView.backgroundColor = [UIColor colorWithHexStr:@"#000000" alpha:0.5];
    baseView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _baseView = baseView;
    [self addSubview:_baseView];

    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = [UIColor whiteColor];
    [showView layer].cornerRadius = 5;
    showView.layer.masksToBounds = YES;
    showView.userInteractionEnabled = YES;
    _showView = showView;
    [self.baseView addSubview:_showView];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = HEXCOLOR(0x333333);
    titleLabel.font = MTFONT16;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    _titleLabel = titleLabel;
    [self.showView addSubview:_titleLabel];

    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.text = self.subTitle;
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    subTitleLabel.textColor =  HEXCOLOR(0x919191);
    subTitleLabel.font = MTFONT14;
    subTitleLabel.numberOfLines = 0;
    _subTitleLabel = subTitleLabel;
    [self.showView addSubview:_subTitleLabel];

    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = content;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.textColor = HEXCOLOR(0x919191);
    contentLabel.font = MTFONT14;
    contentLabel.numberOfLines = 0;
    _contentLabel = contentLabel;
    [self.showView addSubview:_contentLabel];

    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.backgroundColor = HEXCOLOR(0xF3F3F3);
    [cancleBtn setTitleColor:HEXCOLOR(0xF3F3F3) forState:UIControlStateNormal];
    cancleBtn.userInteractionEnabled = YES;
//    [cancleBtn layer].cornerRadius = 3;
    [cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
//    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(alertcancleClick) forControlEvents:UIControlEventTouchUpInside];
    _cancleBtn = cancleBtn;
    [self.showView addSubview:_cancleBtn];

    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor = HEXCOLOR(0x0076DA);
    sureBtn.userInteractionEnabled = YES;
//    [sureBtn layer].cornerRadius = 3;
    [sureBtn setTitle:sureTitle forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(alertSureBtnClk) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn = sureBtn;
    [self.showView addSubview:_sureBtn];
}

- (void)setupLayout{
    CGFloat padding = 15;
//    CGFloat paddingF = (ScreenWidth*0.5-81)*0.6;
    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_baseView.mas_top).offset(kScreenHeight/3);
        make.left.equalTo(_baseView.mas_left).offset(padding);
        make.right.equalTo(_baseView.mas_right).offset(-padding);
        make.bottom.equalTo(_baseView.mas_bottom).offset(-kScreenHeight/3);
    }];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_showView.mas_top).offset(padding);
        make.left.equalTo(_showView.mas_left).offset(0);
        make.right.equalTo(_showView.mas_right).offset(0);
    }];

    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_top).offset(padding*3);
        make.left.equalTo(_titleLabel.mas_left).offset(30);
        make.right.equalTo(_titleLabel.mas_right).offset(-30);
    }];

    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).offset(padding);
        make.left.equalTo(_titleLabel.mas_left).offset(30);
        make.right.equalTo(_titleLabel.mas_right).offset(-30);
    }];

    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_showView.mas_bottom).offset(0);
        make.left.equalTo(_showView.mas_left).offset(0);
        make.width.offset((self.frame.size.width-30)/2);
        make.height.offset(40);
    }];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_showView.mas_bottom).offset(0);
        make.right.equalTo(_showView.mas_right).offset(0);
        make.width.offset((self.frame.size.width-30)/2);
        make.height.offset(40);
    }];

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

- (void)setSubTitle:(NSString *)subTitle {

    _subTitle = subTitle;

    _subTitleLabel.text = _subTitle;
}

- (void)setContentType:(MTAlertViewContentType)contentType {

    _contentType = contentType;

    switch (contentType) {
        case MTAlertViewContentNormal:
        {

            _contentLabel.textColor = HEXCOLOR(0x919191);
        }
            break;
        case MTAlertViewContentBlack:
        {

            _contentLabel.textColor = [UIColor blackColor];
        }
            break;

        default:
            break;
    }

}

@end
