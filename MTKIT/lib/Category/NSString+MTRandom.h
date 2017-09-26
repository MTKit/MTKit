//
//  NSString+MTRandom.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/7/17.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MTRandom)

- (NSString *)randomStringWithLength:(NSInteger)len;

+ (NSString *)randomStringWithLength:(NSInteger)len;
@end
