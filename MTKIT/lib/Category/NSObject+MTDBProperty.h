//
//  NSObject+MTDBProperty.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/9/6.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(MTDBProperty)

/**
 *  插入数据库(Insert Or Replace)
 *
 *  @param className 需要插入的数据的类型(为了解决继承的问题)
 *  @param model     需要插入的数据模型
 *  @param tableName 需要插入的表名
 *  @param SQL       返回的SQL
 *  @param arguments 返回的数据数组
 */
void mt_insertOrReplaceInto(Class className, id model, NSString *tableName, NSString **SQL, NSArray **arguments);
/**
 *  更新数据库
 *
 *  @param className 需要插入的数据的类型(为了解决继承的问题)
 *  @param model     需要插入的数据模型
 *  @param tableName 需要插入的表名
 *  @param query     更新条件
 *  @param SQL       返回的SQL
 *  @param arguments 返回的数据数组
 */
void mt_updateFor(Class className, id model, NSString *tableName, NSArray<NSString *> *query, NSString **SQL, NSArray **arguments);

@end
