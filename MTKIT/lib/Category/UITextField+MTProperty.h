//
//  UITextField+MTProperty.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/5/3.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MTProperty)

@property (nonatomic) NSRange mt_selectedRange;

- (NSRange)mt_convertToSelectedRange;

@end
