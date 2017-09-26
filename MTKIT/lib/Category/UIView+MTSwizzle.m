//
//  UIView+MTSwizzle.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/4/26.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "UIView+MTSwizzle.h"
#import "MTSwizzleTool.h"
@implementation UIView (MTSwizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originSEL = @selector(setImage:forState:);
        SEL swizzleSEL = @selector(mtImg:forState:);
        [MTSwizzleTool MTSwizzleWithClass:[self class]originalSelector:originSEL swizzleSelector:swizzleSEL];
    });
}


- (void)mtImg:(UIImage *)img forState:(UIControlState *)state{
    [self mtImg:img forState:state];

    self.mt_originImg = img;
}
@end
