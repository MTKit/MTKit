//
//  UIView+MTProperty.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/4/26.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTProperty)

@property (nonatomic, copy) NSString *mt_btnNum;
@property (nonatomic, copy) NSString *mt_pageCode;
@property (nonatomic, copy) UIImage *mt_originImg;

@property (nonatomic, assign) BOOL mt_permissionDenied;

/** 最大输入长度 */
@property (nonatomic, assign) int mt_maxInputLength;

@end
