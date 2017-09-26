//
//  MTPictureEmojiView.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/8/3.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "MTPictureEmojiView.h"

@interface MTPictureEmojiView()

@property (nonatomic, weak) UIView *pictureEmojiView;

@property (nonatomic, weak) UILabel *showNumberLabel;

@end

@implementation MTPictureEmojiView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubViews];
        [self setupLayouts];
    }
    return self;
}

- (void)setupSubViews {
    UIView *pictureEmojiView = [[UIView alloc] init];
    pictureEmojiView.backgroundColor = [UIColor whiteColor];
    pictureEmojiView.userInteractionEnabled = YES;
    _pictureEmojiView = pictureEmojiView;
    [self addSubview:_pictureEmojiView];

    // 2.提示 用户 还可以输入多少字
    UILabel *showNumberLabel = [[UILabel alloc] init];
    showNumberLabel.text = [NSString stringWithFormat:@"0 / %ld",self.maxWordCount];
    showNumberLabel.font = [UIFont systemFontOfSize:12];
    showNumberLabel.textColor = KNColorFromRGB(0x8D8D8D);
    showNumberLabel.textAlignment = NSTextAlignmentLeft;
    _showNumberLabel = showNumberLabel;
    [self addSubview:_showNumberLabel];
}

- (void)setupLayouts {

    CGFloat labelWidth = 130;
    CGFloat labelHeight = 11;

    [_pictureEmojiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.width.offset(ScreenWidth);
        make.height.offset(40.0f);
    }];

    [_showNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pictureEmojiView.mas_left).offset(20.0f);
        make.bottom.equalTo(_pictureEmojiView.mas_bottom).offset(-20.0f);
        make.width.offset(labelWidth);
        make.height.offset(labelHeight);
    }];
}


- (void)setMaxWordCount:(NSInteger)maxWordCount {

    _maxWordCount = maxWordCount;

    _showNumberLabel.text = [NSString stringWithFormat:@"0 / %ld",self.maxWordCount];
}

- (void)setUpdataWord:(NSInteger)updataWord {

    _updataWord = updataWord;

    _showNumberLabel.text = [NSString stringWithFormat:@"%ld / %ld",self.updataWord,self.maxWordCount];
}

- (void)setImages:(NSArray<NSString *> *)images {

    _images = images;

    for (int i = 0; i < self.images.count; i++) {

        CGFloat buttonW = 30.0f;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.userInteractionEnabled = YES;
        [button setFrame:CGRectMake(ScreenWidth - (buttonW+20)*(self.images.count-i), 0, buttonW, buttonW)];
        [button setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(picClick:) forControlEvents:UIControlEventTouchUpInside];
        [_pictureEmojiView addSubview:button];
    }
}

- (void)picClick:(UIButton *)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(picEmojiDidselectIndex:)]) {

        [self.delegate picEmojiDidselectIndex:sender.tag];
    }
}



@end
