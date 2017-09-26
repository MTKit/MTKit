//
//  NSString+MTStringHandle.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 2016/9/22.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MTStringHandle)

#define MTStringFromLong(a) [NSString stringWithFormat:@"%ld",a]
#define MTStringFromLongLong(a) [NSString stringWithFormat:@"%lld",a]


- (NSString *)mt_stringByReplaceItems:(NSArray *)items withItems:(NSArray *)replacement;

- (NSAttributedString *)mt_highlightedString:(NSString *)hString highlightedColor:(UIColor *)highlightedColor normalColor:(UIColor *)normalColor;

- (NSAttributedString *)mt_smallString:(NSString *)smallStr smallFontSize:(CGFloat)smallFont bigFontSize:(CGFloat)bigFont color:(UIColor *)color;

- (NSDictionary *)dictionaryType;

/**
 *  去掉字符串左边的特定字符
 *
 *  @param characterSet 需要去除的特定字符集
 *
 *  @return 去除后的字符串
 */
- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;

/**
 *  去掉字符串右边的特定字符
 *
 *  @param characterSet 需要去除的特定字符集
 *
 *  @return 去除后的字符串
 */
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)phoneNumWithCryptograph;

- (NSString *)removeSuffix0;

- (NSString *)mt_removeSearchSpecialString;

- (NSArray *)arrayType;

- (NSDate *)mt_formatDate:(NSString *)format;

@end
