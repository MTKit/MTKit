//
//  UIImage+MTDimensionalCode.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/6/6.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//  二维码

#import <UIKit/UIKit.h>

@interface UIImage (MTDimensionalCode)
/**
 *是否存在二维码
 */
- (BOOL)hasDimensionalCode;
/**
 *存在的二维码的url
 */
- (NSString *)dimensionalCodeUrl;

@end
