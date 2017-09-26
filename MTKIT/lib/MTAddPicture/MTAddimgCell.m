//
//  MTAddimgCell.m
//  ALiEditPhotoCollection
//
//  Created by HaoSun on 2017/8/2.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

#import "MTAddimgCell.h"
#import "MTAddImgModel.h"

@interface MTAddimgCell()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIButton *delBtn;

@end


@implementation MTAddimgCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setupSubViews];
        [self setupLayout];
        
    }
    return self;
}


- (void)setupSubViews {

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)]];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn setImage:[UIImage imageNamed:@"circle_send_close2"] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(delImage:) forControlEvents:UIControlEventTouchUpInside];
    _delBtn = delBtn;
    [imageView addSubview:_delBtn];

}


- (void)setupLayout {

    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
    }];

    [_delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_imageView.mas_right).offset(-5);
        make.top.equalTo(_imageView.mas_top).offset(5);
        make.width.offset(20);
        make.height.offset(20);
    }];

}

- (void)delImage:(UIButton *)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(delImageView:)]) {
        [self.delegate delImageView:_imageModel];
    }
}


- (void)imageViewTap{

    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewTap:)]) {
        [self.delegate imageViewTap:_imageModel];
    }
}

- (void)setImageModel:(MTAddImgModel *)imageModel {

    _imageModel = imageModel;
    _imageView.backgroundColor = [UIColor purpleColor];
    _imageView.image = _imageModel.image;
    
}


@end
