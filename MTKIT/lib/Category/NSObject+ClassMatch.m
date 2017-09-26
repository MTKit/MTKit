//
//  NSObject+ClassMatch.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2016/9/12.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSObject+ClassMatch.h"
#import "MTSwizzleTool.h"

@implementation NSObject (ClassMatch)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        SEL originSEL = @selector(fetchAllConversationsForAccount:);
//        SEL swizzleSEL = @selector(mt_asyncAutoLoginWithUsername:);
//        [MTSwizzleTool MTSwizzleWithClass:NSClassFromString(@"DXDBManager") originalSelector:originSEL swizzleSelector:swizzleSEL];
    });
}


- (void)mt_asyncAutoLoginWithUsername:(id)userName {
    NSLog(@"%@",userName);
}

- (BOOL)mt_isNSStringClass
{
    return [self isKindOfClass:[NSString class]];
}

- (BOOL)mt_isNSDictionaryClass
{
    return [self isKindOfClass:[NSDictionary class]];
}

- (BOOL)mt_isNSArrayClass
{
    return [self isKindOfClass:[NSArray class]];
}

- (int)intValue
{
    if (MTClassMatch(self, NSString)) {
        return [self intValue];
    }
    return 0;
}

- (BOOL)isEqualToString:(NSString *)aString
{
    if ([self isKindOfClass:[NSString class]] == false || [aString isKindOfClass:[NSString class]] == false) {
        return false;
    }else{
        NSString *string = (NSString *)self;
        return [string isEqualToString:aString];
    }
}

@end
