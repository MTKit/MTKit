//
//  NSArray+MTDecription.m
//  MTRealEstate
//
//  Created by HaoSun on 16/11/29.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSArray+MTDecription.h"

@implementation NSArray (MTDecription)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];

    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }

    [str appendString:@")"];

    return str;
}

@end
