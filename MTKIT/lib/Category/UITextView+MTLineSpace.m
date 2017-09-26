//
//  UITextView+MTLineSpace.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/23.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "UITextView+MTLineSpace.h"

@implementation UITextView (MTLineSpace)

- (void)setTextWithLineSpace:(float)lineSpace fontSize:(float)fontSize text:(NSString *)text color:(UIColor *)color
{
    NSString *labelText = text;
    if (labelText.length) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:lineSpace];
        [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        
        NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont systemFontOfSize:fontSize],NSFontAttributeName, color,NSForegroundColorAttributeName,nil];
        [attributedString addAttributes:attributeDict range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
    }
}

@end
