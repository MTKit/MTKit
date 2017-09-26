//
//  UIImage+Extension.m
//  test
//
//  Created by LuKane on 16/5/26.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)resizeableImage:(UIImage *)image resizeImageStyle:(KNResizeImageStyle)resizeImageStyle{
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
    if(resizeImageStyle == KNResizeImageStyleLeft){
        return [image resizableImageWithCapInsets:UIEdgeInsetsMake(w,w * 2 * 0.1,w,w * 2 * 0.9)];
    }
    if(resizeImageStyle == KNResizeImageStyleTop){
        return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h * 0.9 * 2,w,h * 2 * 0.1,w)];
    }
    if(resizeImageStyle == KNResizeImageStyleBottom){
        return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0,h * 2 * 0.5,0)];
    }
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(w,w * 2 * 0.9,w,w * 2 * 0.1)];
}

+ (UIImage *)image:(UIImage *)image transformToSize:(CGSize)size{
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)image:(UIImage *)image scale:(CGFloat)scale{
    CGSize size=CGSizeMake(image.size.width*scale, image.size.height*scale);
    return [self image:image transformToSize:size];
}

@end
