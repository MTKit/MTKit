//
//  NSString+MTStringHandle.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2016/9/22.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSString+MTStringHandle.h"

@implementation NSString (MTStringHandle)

- (NSString *)mt_stringByReplaceItems:(NSArray *)items withItems:(NSArray *)replacement
{
    NSString *ret = self;
    if (items.count == replacement.count) {
        for (int i = 0; i < items.count; i++) {
            ret = [ret stringByReplacingOccurrencesOfString:items[i] withString:replacement[i]];
        }
    }
    return ret;
}

- (NSAttributedString *)mt_highlightedString:(NSString *)hString highlightedColor:(UIColor *)highlightedColor normalColor:(UIColor *)normalColor
{
    NSString *text = [self copy];
    if (text.length && [hString isKindOfClass:[NSString class]]) {
        NSMutableAttributedString *mAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
        
        if(hString.length)
        {
            NSRange highlightedRange = [[text lowercaseString] rangeOfString:[hString lowercaseString]];
            if (highlightedRange.length)
            {
                [mAttributedString setAttributes:@{NSForegroundColorAttributeName:normalColor} range:NSMakeRange(0, text.length)];
                [mAttributedString setAttributes:@{NSForegroundColorAttributeName:highlightedColor} range:highlightedRange];
            }
        }
        return mAttributedString;
    }
    return [[NSMutableAttributedString alloc] initWithString:self];
}

- (NSAttributedString *)mt_smallString:(NSString *)smallStr smallFontSize:(CGFloat)smallFont bigFontSize:(CGFloat)bigFont color:(UIColor *)color
{
    NSString *text = [self copy];
    if (text.length && [smallStr isKindOfClass:[NSString class]]) {
        NSMutableAttributedString *mAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
        
        if(smallStr.length)
        {
            NSRange smallStrRange = [[text lowercaseString] rangeOfString:[smallStr lowercaseString]];
            if (smallStrRange.length)
            {
                [mAttributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:bigFont],NSForegroundColorAttributeName:color} range:NSMakeRange(0, text.length)];
                [mAttributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:smallFont],NSForegroundColorAttributeName:color} range:smallStrRange];
            }
        }
        return mAttributedString;
    }
    return [[NSMutableAttributedString alloc] initWithString:self];
}

- (NSDictionary *)dictionaryType
{
    NSDictionary *dict;
    if (self.length)
    {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        if (data.length)
        {
            NSError *error;
            dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if ([dict isKindOfClass:[NSDictionary class]]) {
                return dict;
            }
        }
    }
    return dict;
}

- (NSArray *)arrayType
{
    NSArray *dict;
    if (self.length)
    {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        if (data.length)
        {
            NSError *error;
            dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if ([dict isKindOfClass:[NSArray class]]) {
                return dict;
            }
        }
    }
    return dict;
}

- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    //This method is unsafe because it could potentially cause buffer overruns.
    //[self getCharacters:charBuffer];
    [self getCharacters:charBuffer range:NSMakeRange(location, length)];
    for (location = 0; location < length; location++) {
        // charBuffer[i] 是 字符对应的ASCII值
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    //[self getCharacters:charBuffer];
    [self getCharacters:charBuffer range:NSMakeRange(location, length)];
    for (length = [self length]; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break ;
        }
    }
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)phoneNumWithCryptograph
{
    if (self.length == 11) {
        NSString *string = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return string;
    }
    return self;
}

- (NSString *)removeSuffix0
{
    NSString *ret = [self copy];
    if ([ret hasSuffix:@".00"]) {
        ret = [ret stringByReplacingOccurrencesOfString:@".00" withString:@""];
    }
    if ([ret hasSuffix:@"0"] && [ret containsString:@"."]) {
        ret = [ret substringToIndex:self.length - 1];
    }
    return ret;
}

- (NSString *)mt_removeSearchSpecialString
{
    NSString *ret = [self mt_stringByReplaceItems:@[@"%",@"'",@"\"",@"<",@">",@"\\",@"_"] withItems:@[@"",@"",@"",@"",@"",@"",@""]];
    return ret;
}

- (NSDate *)mt_formatDate:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate *date = [formatter dateFromString:self];
    return date;
}

@end
