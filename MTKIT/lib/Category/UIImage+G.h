//
//  UIImage+UIImage_G.h
//
//  Created by AlfieL on 14-5-5.
//  Copyright (c) 2014年 cubeTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (G)

/**
 *  拉伸图片
 *
 *  name: 图片名
 */
+ (UIImage *)resizeImageWithImageName:(NSString *)name;

/**
 *  拉伸图片
 *
 *  name: 图片名
 */
+ (UIImage *)resizeImageWithImageName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 *  拉伸图片
 *
 *  name: 图片名
 */
- (UIImage *)resizeImageleft:(CGFloat)left top:(CGFloat)top;
/**
 *  拉伸图片并且改变图片颜色
 *
 *  name: 图片名
 */
+ (UIImage *)resizeImageWithImageName:(NSString *)name left:(CGFloat)left top:(CGFloat)top changeColor:(UIColor *)color;

/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  改变图片的颜色
 *
 *  @param image UIImage对象
 *  @param color UIColor对象
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithColor:(UIImage *)image COLOR:(UIColor *)color;

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color;

- (UIImage *)changeImageColor:(UIColor *)color;

+ (UIImage *)resizeImageWithImage:(UIImage *)image scale:(float)scale;

+ (NSData *)imageDataWithImage:(UIImage*)image
                  scaledToSize:(CGSize)newSize;

- (UIImage *)resizeImageWithNewSize:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)clearColor;

- (BOOL)validQRCode;

- (NSString *)getQRCodeString;

@end
