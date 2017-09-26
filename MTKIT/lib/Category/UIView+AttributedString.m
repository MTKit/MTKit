//
//  UIView+AttributedString.m
//  MoFangGe
//
//  Created by DJ on 14-10-11.
//  Copyright (c) 2014年 com.DJ.www. All rights reserved.
//

#import "UIView+AttributedString.h"

@implementation UIView (AttributedString)

- (NSAttributedString*)currentString:(NSString *)currentString stringColor:(UIColor *)strColor changColor:(UIColor *)changeColor changgeStrArray:(NSArray *)changeStrs
{
    if (!currentString) {
        return nil;
    }
    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:currentString];
    NSRange gl_range;
    gl_range.location=0;
    gl_range.length=currentString.length;
   
    [attributeString addAttribute:NSForegroundColorAttributeName value:strColor range:gl_range];
    

    if ([changeStrs isKindOfClass:[NSNull class]]||changeStrs==nil) {
        return  attributeString;
    }
    
    NSRange indexRange=NSMakeRange(0, 0);
    NSRange tempRange=NSMakeRange(0, 0);
    
    for (int i=0; i<changeStrs.count; i++) {
        NSString *subString=[changeStrs objectAtIndex:i];
        
        if (i==0) {
            tempRange=NSMakeRange(0, 0);
        }else{
            tempRange=indexRange;
        }
        if (tempRange.location+tempRange.length<gl_range.length) {
            
            indexRange=[currentString rangeOfString:subString options:NSCaseInsensitiveSearch range:NSMakeRange(tempRange.location+tempRange.length, gl_range.length-tempRange.location-tempRange.length)];
            
            [attributeString addAttribute:NSForegroundColorAttributeName value:changeColor range:indexRange];
        }
    }
    
    return attributeString;
}

- (NSAttributedString*)currentString:(NSString *)currentString stringFont:(UIFont *)strFont changFont:(UIFont *)changeFont changeStrArray:(NSArray *)changgeStrs
{
    if (!currentString) {
        return nil;
    }
    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:currentString];
    NSRange gl_range;
    gl_range.location=0;
    gl_range.length=currentString.length;
    
    [attributeString addAttribute:NSFontAttributeName value:strFont range:gl_range];
    
    NSRange indexRange=NSMakeRange(0, 0);
    NSRange tempRange=NSMakeRange(0, 0);
    
    for (int i=0; i<changgeStrs.count; i++) {
        NSString *subString=[changgeStrs objectAtIndex:i];
        
        if (i==0) {
            tempRange=NSMakeRange(0, 0);
        }else{
            tempRange=indexRange;
        }
        if (tempRange.location+tempRange.length<gl_range.length) {
            
            indexRange=[currentString rangeOfString:subString options:NSCaseInsensitiveSearch range:NSMakeRange(tempRange.location+tempRange.length, gl_range.length-tempRange.location-tempRange.length)];
            
             [attributeString addAttribute:NSFontAttributeName value:changeFont range:indexRange];
        }
    }
    return attributeString;
}

- (NSAttributedString*)currentString:(NSString *)currentString lineSpace:(CGFloat)lineSpace worldSpace:(CGFloat)worldSpace
{
    if (!currentString) {
        return nil;
    }
    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:currentString];
    NSRange gl_range;
    gl_range.location=0;
    gl_range.length=currentString.length;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    [attributeString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:gl_range];

    [attributeString addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:worldSpace] range:gl_range];
    return attributeString;
}
@end
