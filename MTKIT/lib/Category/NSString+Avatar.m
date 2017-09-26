//
//  NSString+Avatar.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/24.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSString+Avatar.h"

@implementation NSString (Avatar)

- (NSURL *)mt_URLForAvatar
{
    if (self.length) {
        if (![self hasPrefix:URL_SYS_UPLOAD] && [self hasPrefix:@"https://"] == false && [self hasPrefix:@"http://"] == false) {
            return [NSURL URLWithString:[URL_SYS_UPLOAD stringByAppendingString:self]];
        }
        return [NSURL URLWithString:self];
    }
    return [NSURL URLWithString:@""];
}

- (NSURL *)mt_URLForHouse
{
    if (self.length) {
        if ([self hasPrefix:@"http"] == false) {
//            @"http://bjimg-test.imtfc.com:8088/"
            NSString *urlString = [self copy];
            if ([urlString hasPrefix:@"/"] && [MT_ONLINE_IMG_SERVER_PREFIX hasSuffix:@"/"]) {
                urlString = [urlString substringFromIndex:1];
            }
            return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",MT_ONLINE_IMG_SERVER_PREFIX,urlString]];
        }
        return [NSURL URLWithString:self];
    }
    return [NSURL URLWithString:@""];
}

@end
