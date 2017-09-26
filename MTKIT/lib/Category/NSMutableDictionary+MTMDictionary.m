//
//  NSMutableDictionary(MTMDictionary).m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/9/1.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSMutableDictionary+MTMDictionary.h"

@implementation NSMutableDictionary (MTMDictionary)

void mtDicAdd(NSMutableDictionary *dict, id object, NSString *key)
{
    [dict mt_setObject:object forKey:key];
}

- (void)mt_setObject:(id)object forKey:(NSString *)key
{
    if ([key isKindOfClass:[NSString class]]) {
        if (object && key.length) {
            [self setObject:object forKey:key];
        }
    }
}

+ (NSMutableDictionary *)initWithKeyValues:(void (^)(NSMutableDictionary *))addValue
{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    if (addValue) {
        addValue(mDic);
    }
    return mDic;
}

- (void (^)(id value, NSString *key))add
{
    return ^(id value, NSString *key){
        [self mt_setObject:value forKey:key];
    };
}

@end
