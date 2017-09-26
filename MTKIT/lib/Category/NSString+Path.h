//
//  NSString+Path.h
//
//  Created by SuperZM on 14/2/16.
//  Copyright © 2014年 SuperZM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)
/**
 *  追加文档目录
 */
- (NSString *)appendDocumentDir;

/**
 *  追加缓存目录
 */
- (NSString *)appendCacheDir;

/**
 *  追加临时目录
 */
- (NSString *)appendTempDir;
//返回文字的拼音
- (NSString *)pinyin;

- (NSString *)getEveryWordFirstLittre;
@end
