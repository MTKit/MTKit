//
//  MTSwizzleTool.h
//  MTRealEstate
//
//  Created by HaoSun on 16/6/27.
//  Copyright © 2016年 liusongpo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTSwizzleTool : NSObject

+ (void)MTSwizzleWithClass:(Class)processedClass originalSelector:(SEL)originSelector swizzleSelector:(SEL)swizzlSelector;

@end
