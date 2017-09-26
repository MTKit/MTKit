//
//  NSObject+ClassMatch.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 2016/9/12.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ClassMatch)

- (BOOL)mt_isNSStringClass;
- (BOOL)mt_isNSDictionaryClass;
- (BOOL)mt_isNSArrayClass;

- (int)intValue;

@end
