//
//  UIColor+Hexcolor.h
//  MTKIT
//
//  Created by 鲁志刚 on 2017/9/26.
//  Copyright © 2017年 MTKIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

@interface UIColor_Hexcolor : UIColor

@end
