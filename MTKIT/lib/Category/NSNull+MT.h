//
//  NSNull+MT.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 2016/9/12.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull_MT : NSNull

- (NSInteger)length;

- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)searchSet;

- (int)intValue;

@end
