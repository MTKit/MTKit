//
//  UIBarButtonItem+Extension.h
//  妈咪宝贝
//
//  Created by apple on 15/7/9.
//  Copyright (c) 2015年 BFHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


/**
 *  返回一个navigation按钮
 *
 *  @param image    传入的normal图片
 *  @param selImage 传入一个selected图片
 *  @param target   target
 *  @param action   实现方法
 *
 *  @return 返回一个按钮
 */
+ (instancetype)itemWithImage:(NSString *)image selectedImage:(NSString *)selImage target:(id)target action:(SEL)action;


/**
 *  返回一个navigation按钮
 *
 *  @param title  传入字符串
 *  @param target target
 *  @param action 实现方法
 *
 *  @return 返回一个按钮
 */
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)itemBlackWithTitle:(NSString *)title target:(id)target action:(SEL)action;


@end
