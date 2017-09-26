//
//  NSString+MTRoSpace.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/7/28.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "NSString+MTRoSpace.h"

@implementation NSString (MTRoSpace)
- (NSString *)removeSpace {

    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
@end
