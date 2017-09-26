//
//  NSDictionary+MTDecription.m
//  MTRealEstate
//
//  Created by HaoSun on 16/11/29.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSDictionary+MTDecription.h"

@implementation NSDictionary (MTDecription)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value= self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];

    return str;
}

- (NSString *)mt_stringValue
{
    NSString *rect = nil;
    
    if (self.count && [NSJSONSerialization isValidJSONObject:self])
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
        if (jsonData && jsonData.length)
        {
            rect = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    
    return rect;
}


@end
