//
//  NSString+Avatar.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/24.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSString+Avatar.h"

@implementation NSString (URLExtension)

- (NSURL *)mt_URLForPrefix:(NSString *)urlPrefix
{
    if (self.length) {
        if (![self hasPrefix:urlPrefix] && [self hasPrefix:@"https://"] == false && [self hasPrefix:@"http://"] == false) {
            return [NSURL URLWithString:[urlPrefix stringByAppendingString:self]];
        }
        return [NSURL URLWithString:self];
    }
    return [NSURL URLWithString:@""];
}

@end
