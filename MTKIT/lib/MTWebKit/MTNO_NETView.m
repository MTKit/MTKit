//
//  MTNO_NETView.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/5/3.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "MTNO_NETView.h"

@interface MTNO_NETView()

@property (nonatomic,strong) UIImageView *hanImgView;
@property (nonatomic,strong) UILabel *netErrorLaebl;

@end

@implementation MTNO_NETView

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        [self setNetErrorWithView:view];
    }
    return self;
}

- (void)setNetErrorWithView:(UIView *)view{
    self.hanImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"han"]];
    [view addSubview:self.hanImgView];
    [self.hanImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_equalTo(160.0f);
        make.width.height.mas_equalTo(150.0f);
    }];

    self.netErrorLaebl = [[UILabel alloc] init];
    self.netErrorLaebl.font = [UIFont systemFontOfSize:20];
    self.netErrorLaebl.textColor = HEXCOLOR(0xABABAB);
    self.netErrorLaebl.text = @"网络连接失败";
    [view addSubview:self.netErrorLaebl];
    [self.netErrorLaebl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_equalTo(self.hanImgView.mas_bottom).mas_offset(50.0f);
    }];
}

@end
