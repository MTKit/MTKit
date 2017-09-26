//
//  NSTimer+MTAddition.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/5/12.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "NSTimer+MTAddition.h"

@implementation NSTimer (MTAddition)
- (void)pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}
@end
