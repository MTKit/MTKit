//
//  UIButton+MTSwizzle.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/4/26.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "UIButton+SwizzleMT.h"
#import "MTSwizzleTool.h"
#import "UIImage+Tint.h"
#import "UIImage+MTExtension.h"
#import "UIView+MTProperty.h"

@implementation UIButton (SwizzleMT)

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

    if (self.mt_permissionDenied == false) {
        self.mt_originImg = img;
    }
}

- (void)mt_setButtonPermissionDenied
{
    if (self.mt_originImg) {
        [self setImage:[self.mt_originImg clearColor] forState:UIControlStateNormal];
    }
}

- (void)mt_setButtonPermissionAllow
{
    if (self.mt_originImg) {
        [self setImage:self.mt_originImg forState:UIControlStateNormal];
    }
}

@end
