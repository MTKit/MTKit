//
//  NSMutableDictionary(MTMDictionary).h
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/9/1.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (MTMDictionary)

void mtDicAdd(NSMutableDictionary *dict, id object, NSString *key);

- (void)mt_setObject:(id)object forKey:(NSString *)key;

//- (void)mt_add:(id)object forKey:(NSString *)key;

+ (NSMutableDictionary *)initWithKeyValues:(void (^)(NSMutableDictionary *dic))addValue;

- (void (^)(id value,NSString *key))add;

@end
