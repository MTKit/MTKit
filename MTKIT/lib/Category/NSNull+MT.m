//
//  NSNull+MT.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2016/9/12.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSNull+MT.h"

@implementation NSNull(MT)

- (NSInteger)length
{
    return 0;
}

- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)searchSet
{
    return NSMakeRange(0, 0);
}

- (int)intValue
{
    return 0;
}

@end
