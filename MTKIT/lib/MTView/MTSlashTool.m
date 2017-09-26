//
//  MTSlashTool.m
//  MTRealEstate
//
//  Created by HaoSun on 16/8/8.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//  画一条斜线

#import "MTSlashTool.h"

@implementation MTSlashTool

/**
 *  画一条斜线
 */
- (void)drawRect:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 0 / 255.0, 0 / 255.0, 0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width, 0);  //起点坐标
    CGContextAddLineToPoint(context, 0, self.frame.size.height);   //终点坐标
    CGContextStrokePath(context);
}

@end
