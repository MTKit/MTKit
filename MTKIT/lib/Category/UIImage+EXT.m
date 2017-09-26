//
//  UIImage+EXT.m
//  12313
//
//  Created by issuser on 16/6/22.
//  Copyright © 2016年 joemo. All rights reserved.
//

#import "UIImage+EXT.h"

@implementation UIImage (EXT)

+ (instancetype)watermarkImageWithBgImage:(NSString *)bgImage withLogo:(NSString *)logoImage{
    UIImage *bg = [UIImage imageNamed:bgImage];
    
    UIGraphicsBeginImageContextWithOptions(bg.size, NO, 0.0);
    
    [bg drawAtPoint:CGPointMake(0, 0)];
    
    UIImage *logo = [UIImage imageNamed:logoImage];
    
    CGFloat margin = 5;
    
    CGFloat scale = 0.2;
    
    CGFloat logoW = logo.size.width * scale;
    
    CGFloat logoH = logo.size.height * scale;
    
    CGFloat logoX = bg.size.width - logoW - margin;
    
    CGFloat logoY = bg.size.height - logoH - margin;
    
    [logo drawInRect:CGRectMake(logoX, logoY, logoW, logoH)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = 0.0;    // 大圆半径
    CGFloat centerX = 0.0;      // 圆心
    CGFloat centerY = 0.0;
    if (imageW > imageH) {
        bigRadius = imageH * 0.5;
        centerX = imageW * 0.5;
        centerY = imageH * 0.5;
    }else if (imageW < imageH){
        bigRadius = imageW * 0.5;
        centerX = imageW * 0.5;
        centerY = imageH * 0.5;
    }else{
        bigRadius = imageW * 0.5;
        centerX = bigRadius;
        centerY = bigRadius;
    }
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *) captureWithView:(UIView *)view{
    UIGraphicsBeginImageContext(view.frame.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)circleImage {

    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);

    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);

    // 裁剪
    CGContextClip(ctx);

    // 将原照片画到图形上下文
    [self drawInRect:rect];

    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
