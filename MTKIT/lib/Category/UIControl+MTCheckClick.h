//
//  UIControl+MTCheckClick.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/4/13.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (MTCheckClick)
@property (nonatomic, assign) NSTimeInterval cs_acceptEventInterval; // 重复点击的间隔

@property (nonatomic, assign) NSTimeInterval cs_acceptEventTime;
@end
