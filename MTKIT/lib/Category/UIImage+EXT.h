//
//  UIImage+EXT.h
//  12313
//
//  Created by issuser on 16/6/22.
//  Copyright © 2016年 joemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EXT)

/**
 *  添加水印
 *
 *  @param bgImage 背景图片
 *  @param logo    水印logo
 *
 *  @return 实例对象
 */
+ (instancetype)watermarkImageWithBgImage:(NSString *)bgImage withLogo:(NSString *)logo;

/**
 *  生成圆形图片
 *
 *  @param name        原图名称
 *  @param borderWidth 圆形边宽
 *  @param borderColor 圆形边颜色
 *
 *  @return 图片
 */
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  截图
 *
 *  @param view 截图对象所在视图
 *
 *  @return 图片
 */
+ (UIImage *) captureWithView:(UIView *)view;

/**
 * 画圆角
 *
 *
 */
- (UIImage *)circleImage;
@end
