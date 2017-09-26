//
//  NSTimer+MTAddition.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/5/12.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (MTAddition)
- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;
@end
