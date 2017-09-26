//
//  UIView+AttributedString.h
//  MoFangGe
//
//  Created by DJ on 14-10-11.
//  Copyright (c) 2014年 com.DJ.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AttributedString)

/**
*  改变字体颜色
*
*  @param currentString 当前的字符串
*  @param strColor      当前字符串的颜色
*  @param changeColor   需要改变的颜色
*  @param changeStrs    需要改变的字符串的集合
*
*  @return 新的属性化字符串
*/
- (NSAttributedString*)currentString:(NSString*)currentString stringColor:(UIColor*)strColor changColor:(UIColor*)changeColor changgeStrArray:(NSArray*)changeStrs;

/**
 *  改变字体的大小
 *
 *  @param currentString 当前的字符串
 *  @param strFont       当前字符串的字体大小
 *  @param changeFont    需要改变的字体大小
 *  @param changgeStrs   需要改变的字符串的集合
 *
 *  @return 新的属性化字符串
 */
- (NSAttributedString*)currentString:(NSString *)currentString stringFont:(UIFont *)strFont changFont:(UIFont *)changeFont changeStrArray:(NSArray*)changgeStrs;

/**
 *  改变字体的行距和字体距离
 *
 *  @param currentString 当前的字符串
 *  @param lineSpace     行距
 *  @param worldSpace    字距
 *
 *  @return 新的属性化字符串
 */
- (NSAttributedString*)currentString:(NSString *)currentString lineSpace:(CGFloat )lineSpace worldSpace:(CGFloat )worldSpace ;

@end
