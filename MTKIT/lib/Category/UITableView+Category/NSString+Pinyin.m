//
//  NSString+Pinyin.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/7/28.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSString+Pinyin.h"

@implementation NSString (Pinyin)

- (NSString *)pingyinValueWithTone:(BOOL)tone
{
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    if (tone) {
        // 带声调的拼音
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    }else{
        // 无声调的拼音
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    }
    return mutableString;
}

@end
