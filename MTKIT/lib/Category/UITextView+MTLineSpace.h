//
//  UITextView+MTLineSpace.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/23.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextView (MTLineSpace)

- (void)setTextWithLineSpace:(float)lineSpace fontSize:(float)fontSize text:(NSString *)text color:(UIColor *)color;

@end
