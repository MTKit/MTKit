//
//  NSDictionary+(MTProperty).m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/24.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSDictionary+MTProperty.h"

@implementation NSDictionary (MTProperty)

- (NSDictionary *)mt_dictValueForKey:(NSString *)dict
{
    id obj = [self objectForKey:dict];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }
    return nil;
}

- (NSNumber *)mt_numberValueForKey:(NSString *)key
{
    NSNumber *number = nil;
    if (key.length) {
        id obj = [self objectForKey:key];
        if (obj) {
            if ([obj isKindOfClass:[NSNumber class]]) {
                number = obj;
            }
        }
    }
    return number;
}

- (int)mt_intValueForKey:(NSString *)key
{
    return [[self mt_numberValueForKey:key] intValue];
}

- (NSString *)mt_stringValueForKey:(NSString *)key
{
    if (key.length) {
        id obj = [self objectForKey:key];
        if ([obj isKindOfClass:[NSString class]]) {
            return obj;
        }
    }
    return nil;
}

- (NSInteger)mt_integerValueForKey:(NSString *)key
{
    return [self mt_numberValueForKey:key].integerValue;
}

@end
