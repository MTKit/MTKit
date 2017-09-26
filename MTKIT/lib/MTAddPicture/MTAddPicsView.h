//
//  MTAddPicsView.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/8/2.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TZImagePickerController.h"
#import "MTAddimgCell.h"
#import "MTAddImgModel.h"

@interface MTAddPicsView : UIView

@property (nonatomic, assign) NSInteger maxPhoto;//默认是9

@property (nonatomic, assign) BOOL addBtnHidden;

/**
 获取所有的图片
 */
- (NSArray *)getImages;

/**
 获取所有的图片 以模型的形式
 */
- (NSArray *)getImagesModel;

/**
 当没有+号按钮的时候，调用这个方法进入图片选择页面
 */
- (void)addImage;

/**
 当有存草稿的情况时， 展示的图片
 */
- (void)showNumPics:(NSArray *)images;

@end
