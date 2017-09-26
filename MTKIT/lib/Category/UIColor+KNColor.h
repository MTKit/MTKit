//
//  UIColor+KNColor.h
//  妈咪宝贝
//
//  Created by LUKHA_Lu on 15/6/20.
//  Copyright (c) 2015年 BFHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KNColor)

/**
 * 通过RGB设置颜色
 *
 *  @param red   r
 *  @param green g
 *  @param blue  b
 *
 *  @return 返回一个color
 */
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue;

/**
 *  通过RGB设置颜色,alpha设置透明度
 *
 *  @param red   r
 *  @param green g
 *  @param blue  b
 *  @param alpha 透明度
 *
 *  @return 返回一个color带有透明度
 */

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue alpha:(CGFloat)alpha;


+ (UIColor *)colorWithHexStr:(NSString *)hexStr alpha:(CGFloat)alpha;
@end
