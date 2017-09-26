//
//  MTSwizzleTool.m
//  MTRealEstate
//
//  Created by HaoSun on 16/6/27.
//  Copyright © 2016年 liusongpo. All rights reserved.
//

#import "MTSwizzleTool.h"

#import <objc/runtime.h>

@implementation MTSwizzleTool

+(void)MTSwizzleWithClass:(Class)processedClass originalSelector:(SEL)originSelector swizzleSelector:(SEL)swizzlSelector{
    Method originMethod = class_getInstanceMethod(processedClass, originSelector);
    Method swizzleMethod = class_getInstanceMethod(processedClass, swizzlSelector);

    BOOL didAddMethod = class_addMethod(processedClass, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));

    if (didAddMethod) {
        class_replaceMethod(processedClass, swizzlSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzleMethod);

    }
    
}

@end
