//
//  NSString+Path.m
//
//  Created by SuperZM on 14/2/16.
//  Copyright © 2014年 SuperZM. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)
/**
 *  追加文档目录
 */
- (NSString *)appendDocumentDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

/**
 *  追加缓存目录
 */
- (NSString *)appendCacheDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

/**
 *  追加临时目录
 */
- (NSString *)appendTempDir{
    NSString *path = NSTemporaryDirectory();
    return [self appendWithPath:path];
}

// 在传入的路径后拼接当前的字符串
- (NSString *)appendWithPath:(NSString *)path{
    return [path stringByAppendingPathComponent:self];
}
//返回文字的拼音
- (NSString *)pinyin {
  
    NSMutableString *str1 = [self mutableCopy];
    NSString *str = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([[self substringToIndex:1] isEqualToString:@"沈"]) {
        return @"S";
    }
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [[[str stringByReplacingOccurrencesOfString:@" " withString:@""]substringToIndex:1]uppercaseString];
}
- (NSString *)getEveryWordFirstLittre{
    NSMutableString *s = [NSMutableString string];
    NSString *str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    for(int i = 0;i<str.length;i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *t = [str substringWithRange:range];
        NSString *t1 = [t pinyin];
        [s appendString:t1];
    }
    return s.copy;
}
@end
