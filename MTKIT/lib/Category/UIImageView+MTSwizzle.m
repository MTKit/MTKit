//
//  UIImageView+MTSwizzle.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/4/27.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "UIImageView+MTSwizzle.h"
#import "MTSwizzleTool.h"
#import "UIImage+Tint.h"
#import "UIImage+G.h"

@implementation UIImageView (MTSwizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originSEL = @selector(setImage:);
        SEL swizzleSEL = @selector(mtSetImg:);
        [MTSwizzleTool MTSwizzleWithClass:[self class]originalSelector:originSEL swizzleSelector:swizzleSEL];
    });
}

- (void)mtSetImg:(UIImage *)img
{
    [self mtSetImg:img];
    if (self.mt_permissionDenied == false) {
        self.mt_originImg = img;
    }
}

- (void)setImageViewPermissionDenied:(BOOL)denied
{
    if (denied) {
        self.image = [self.mt_originImg clearColor];
    }else{
        self.image = self.mt_originImg;
    }
}



@end
