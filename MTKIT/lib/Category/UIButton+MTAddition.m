//
//  UIButton+MTAddition.m
//  MTRealEstate
//
//  Created by HaoSun on 16/6/27.
//  Copyright © 2016年 liusongpo. All rights reserved.
//

#import "UIButton+MTAddition.h"

#import <objc/runtime.h>

@implementation UIButton (MTAddition)

static void *key;
- (void)setMTLogTitle:(NSString *)MTLogTitle{

    objc_setAssociatedObject(self, key, MTLogTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)MTLogTitle{

    return  objc_getAssociatedObject(self, key);
    
}

@end
