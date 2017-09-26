//
//  MTTempController.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/8/2.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "MTTempController.h"
#import "MTAddPicsView.h"
#import "MTPictureEmojiView.h"
@interface MTTempController ()<MTPictureEmojiViewDelegate>
@property (nonatomic, weak) MTAddPicsView *picview;
@end

@implementation MTTempController

- (void)viewDidLoad {
    [super viewDidLoad];

//    MTAddPicsView *view = [[MTAddPicsView alloc] init];
//    view.maxPhoto = 3;
//    view.frame = CGRectMake(0, 188, ScreenWidth, 500);
//    view.addBtnHidden = YES;
//    _picview = view;
//    [self.view addSubview:_picview];
    [self setupBtn];

    [self setupPictureEmojiView];

}

- (void)setupBtn {

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 80, ScreenWidth, 30);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btn];
}

- (void)setupPictureEmojiView {

    MTPictureEmojiView *view = [[MTPictureEmojiView alloc] init];
    view.frame = CGRectMake(0, 300, ScreenWidth, 40);
    view.maxWordCount = 140;
    view.images = @[@"circle_send_selectImage",@"circle_send_Emoji"];
    view.delegate = self;
    [self.view addSubview:view];

}

- (void)picEmojiDidselectIndex:(NSInteger)index {

    NSLog(@"点击了-----%ld",index);
}

- (void)btnClick {

    NSLog(@"-source--%@---\n model -- %@",[_picview getImages],[_picview getImagesModel]);
    [_picview addImage];
}

@end
