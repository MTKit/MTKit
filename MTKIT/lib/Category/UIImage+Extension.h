//
//  UIImage+Extension.h
//  test
//
//  Created by LuKane on 16/5/26.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

typedef enum{
    KNResizeImageStyleLeft,
    KNResizeImageStyleRight,
    KNResizeImageStyleTop,
    KNResizeImageStyleBottom
}KNResizeImageStyle;

/**
 *  拉伸图片
 *
 *  @param image            原图片
 *  @param resizeImageStyle 拉伸样式
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)resizeableImage:(UIImage *)image resizeImageStyle:(KNResizeImageStyle)resizeImageStyle;


/**
 *  缩放指定大小
 *
 *  @param image 原图片
 *  @param size  大小
 *
 *  @return 缩放后的图片
 */
+ (UIImage *)image:(UIImage *)image transformToSize:(CGSize)size;

/**
 *  缩放指定比率
 *
 *  @param image 原图片
 *  @param scale 大小比率
 *
 *  @return 缩放后的图片
 */
+ (UIImage *)image:(UIImage *)image scale:(CGFloat)scale;



@end
