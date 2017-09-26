//
//  NSDictionary+(MTProperty).h
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/24.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MTProperty)

- (NSDictionary *)mt_dictValueForKey:(NSString *)dict;
- (NSNumber *)mt_numberValueForKey:(NSString *)key;
- (int)mt_intValueForKey:(NSString *)key;
- (NSString *)mt_stringValueForKey:(NSString *)key;
- (NSInteger)mt_integerValueForKey:(NSString *)key;

@end
