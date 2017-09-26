//
//  NSObject+MTDBProperty.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/9/6.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSObject+MTDBProperty.h"
#import <objc/runtime.h>

@implementation NSObject(MTDBProperty)

+ (NSArray *)propertyNames
{
    ///存储所有的属性名称
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        NSString *obj = [NSString stringWithUTF8String:propertyName];
        if ([obj isEqualToString:@"hash"] == false && [obj isEqualToString:@"description"] == false && [obj isEqualToString:@"superclass"] == false && [obj isEqualToString:@"debugDescription"] == false)
        {
            [allNames addObject:obj];
        }
    }
    
    ///释放
    free(propertys);
    
    return allNames;
}

void mt_insertOrReplaceInto(Class className, id model, NSString *tableName, NSString **SQL, NSArray **arguments)
{
    NSArray *propties = [className propertyNames];
    if (propties.count) {
        NSString *proptyString = [propties componentsJoinedByString:@","];
        if (proptyString.length) {
            
            NSMutableString *valuesPlaceHolders = [NSMutableString string];
            [propties enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0) {
                    [valuesPlaceHolders appendString:@"?"];
                }else{
                    [valuesPlaceHolders appendString:@",?"];
                }
            }];
            NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@) VALUES (%@)",tableName,proptyString,valuesPlaceHolders];
            *SQL = sql;
            
            NSMutableArray *argumentsArray = [NSMutableArray array];
            NSDictionary *valueDict = [model dictionaryWithValuesForKeys:propties];
            [propties enumerateObjectsUsingBlock:^(NSString *propertyKey, NSUInteger idx, BOOL * _Nonnull stop) {
                id value = [valueDict objectForKey:propertyKey];
                if (value) {
                    [argumentsArray addObject:value];
                }else{
                    [argumentsArray addObject:[NSNull null]];
                }
            }];
            
            *arguments = argumentsArray;
        }
    }
}

void mt_updateFor(Class className, id model, NSString *tableName, NSArray<NSString *> *query, NSString **SQL, NSArray **arguments)
{
    if (query.count) {
        NSArray *propties = [className propertyNames];
        if (propties.count) {
            NSString *proptyString = [propties componentsJoinedByString:@"=?,"];
            if (proptyString.length) {
                
                NSString *queryHolders = [query componentsJoinedByString:@"=?,"];
                NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",tableName,proptyString,queryHolders];
                *SQL = sql;
                
                NSMutableArray *argumentsArray = [NSMutableArray array];
                NSDictionary *valueDict = [model dictionaryWithValuesForKeys:propties];
                [propties enumerateObjectsUsingBlock:^(NSString *propertyKey, NSUInteger idx, BOOL * _Nonnull stop) {
                    id value = [valueDict objectForKey:propertyKey];
                    if (value) {
                        [argumentsArray addObject:value];
                    }else{
                        [argumentsArray addObject:[NSNull null]];
                    }
                }];
                
                [query enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyKey, NSUInteger idx, BOOL * _Nonnull stop) {
                    id value = [valueDict objectForKey:propertyKey];
                    if (value) {
                        [argumentsArray addObject:value];
                    }else{
                        [argumentsArray addObject:[NSNull null]];
                    }
                }];
                
                *arguments = argumentsArray;
            }
        }
    }else{
        @throw @"query 不能是空的";
    }
}

/*
+ (NSString *)updateFor:(NSString *)tableName
{
    NSMutableString *mString = [NSMutableString stringWithString:@"("];
    for (NSString *property in [self propertyNames]) {
        [mString appendFormat:@":%@,",property];
    }
    NSRange range = [mString rangeOfString:@"," options:NSBackwardsSearch];
    NSString *property = [mString stringByReplacingOccurrencesOfString:@"," withString:@"" options:NSBackwardsSearch range:range];
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ %@",tableName,property];
    return sql;
}

+ (NSString *)insertOrReplaceFor:(NSString *)tableName
{
    NSMutableString *mString = [NSMutableString stringWithString:@"("];
    int i = 0;
    NSArray *propertyNames = [self propertyNames];
    for (NSString *property in propertyNames) {
        if(i == 0){
            [mString appendFormat:@":%@,",property];
        }else if (i < propertyNames.count - 1) {
            [mString appendFormat:@" :%@,",property];
        }else{
            [mString appendFormat:@" :%@)",property];
        }
        i++;
    }
    
    NSString *sql = [NSString stringWithFormat:@"%@ values %@",[NSString stringWithFormat:@"INSERT OR REPLACE INTO %@",tableName],mString];
    return sql;
}

- (NSDictionary *)_db_keyValuesForClass:(Class)className
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *propties = [className propertyNames];
    [propties enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        id obj = [self valueForKey:key];
        if (obj) {
            [dict setObject:obj forKey:key];
        }
    }];
    return dict;
}
 */
/**
 *  插入数据库, 该方法可能会造成数据库写入的混乱, SQLite写入的时候, 先按fieldName来查找该field的Index, 而这个Index有时候查出来是不正确的, 没有找到原因, 所以先不用这个方法
 *
 *  @param tableName 表明
 *
 *  @return SQL语句
 */
- (NSString *)_insertOrReplaceIntoForTable:(NSString *)tableName
{
    NSArray *propties = [self.class propertyNames];
    if (propties.count) {
        NSString *proptyString = [propties componentsJoinedByString:@","];
        if ([proptyString hasSuffix:@","] && proptyString.length > 2) {
            proptyString = [proptyString substringToIndex:proptyString.length-2];
            
            NSMutableString *valuesString = [NSMutableString string];
            [propties enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0) {
                    [valuesString appendString:@"?"];
                }else{
                    [valuesString appendString:@",?"];
                }
            }];
            NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@) VALUES (%@)",tableName,proptyString,valuesString];
            return sql;
        }
    }
    return @"";
}

@end
