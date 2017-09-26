//
//  UILabel(MTKeyWord).m
//  CoreText
//
//  Created by 鲁志刚 on 16/7/27.
//  Copyright © 2016年 MaiTian. All rights reserved.
//

#import "UILabel+MTKeyWord.h"
#import <CoreText/CoreText.h>

@implementation UILabel(MTKeyWord)
/*
- (NSAttributedString *)keyLineWithKeyword:(NSString *)keyword
{
    if (self.text.length && keyword.length) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentLeft;//设置对齐方式
        paragraph.lineBreakMode = NSLineBreakByCharWrapping;
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.text attributes:@{NSFontAttributeName : self.font,NSForegroundColorAttributeName : [UIColor blackColor],NSParagraphStyleAttributeName : paragraph}];
        
        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
        CGMutablePathRef path = CGPathCreateMutable();
        CGSize size = [self sizeThatFits:CGSizeMake(self.frame.size.width, 0)];
        CGPathAddRect(path, NULL, CGRectMake(0, 0, self.frame.size.width, size.height));
        NSInteger length = attributedString.length;
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL);
        
        NSString *lineString = [self keyLineForKeyword:keyword frame:frame text:self.text];
        CFRelease(frame);
        CFRelease(path);
        CFRelease(frameSetter);
        
        UIColor *color = [UIColor colorWithRed:((0x0076DA>>16)&0xFF)/255.0 green:((0x0076DA>>8)&0xFF)/255.0 blue:(0x0076DA&0xFF)/255.0 alpha:1.0];
        // 大小写
        NSMutableArray <NSString *> * rangeArray = [NSMutableArray array];
        
        BOOL endSearch = false;
        NSString *tmpString = lineString;
        NSRange range = NSMakeRange(0, 0);
        while (endSearch == false) {
            NSRange keywordRange = [[tmpString lowercaseString] rangeOfString:[keyword lowercaseString] options:NSAnchoredSearch range:NSMakeRange(range.location+range.length, tmpString.length-range.length-range.location)];
            
            if (keywordRange.length) {
                if (tmpString.length < keyword.length) {
                    endSearch = true;
                }
                range = keywordRange;
                [rangeArray addObject:NSStringFromRange(keywordRange)];
            }else{
                endSearch = true;
            }
        }
        
        NSMutableAttributedString *ret;
        
        if (lineString.length && keyword.length) {
            ret = [[NSMutableAttributedString alloc] initWithString:lineString attributes:@{NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.textColor}];
            if (ret.length) {
                [rangeArray enumerateObjectsUsingBlock:^(NSString * _Nonnull objRane, NSUInteger idx, BOOL * _Nonnull stop) {
                    [ret addAttribute:NSForegroundColorAttributeName value:color range:NSRangeFromString(objRane)];
                }];
            }
        }
        return ret;
    }
    return nil;
}
*/
- (NSAttributedString *)keyLineWithKeyword:(NSString *)keyword
{
    if (self.text.length) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentLeft;//设置对齐方式
        paragraph.lineBreakMode = NSLineBreakByCharWrapping;
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.text attributes:@{NSFontAttributeName : self.font,NSForegroundColorAttributeName : [UIColor blackColor],NSParagraphStyleAttributeName : paragraph}];
        
        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
        CGMutablePathRef path = CGPathCreateMutable();
        CGSize size = [self sizeThatFits:CGSizeMake(self.frame.size.width, 0)];
        CGPathAddRect(path, NULL, CGRectMake(0, 0, self.frame.size.width, size.height));
        NSInteger length = attributedString.length;
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL);
        
        NSString *lineString = [self keyLineForKeyword:keyword frame:frame text:self.text];
        CFRelease(frame);
        CFRelease(path);
        CFRelease(frameSetter);
        
        UIColor *color = [UIColor colorWithRed:((0x0076DA>>16)&0xFF)/255.0 green:((0x0076DA>>8)&0xFF)/255.0 blue:(0x0076DA&0xFF)/255.0 alpha:1.0];
        // 大小写
        NSRange keywordRange = [[lineString lowercaseString] rangeOfString:[keyword lowercaseString]];
        NSMutableAttributedString *ret;
        
        if (lineString.length && keyword.length) {
            ret = [[NSMutableAttributedString alloc] initWithString:lineString attributes:@{NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.textColor}];
            if (ret.length && keywordRange.length) {
                [ret addAttribute:NSForegroundColorAttributeName value:color range:keywordRange];
            }
        }
        return ret;
    }
    return nil;
}

- (NSString *)keyLineForKeyword:(NSString *)keyword frame:(CTFrameRef)frame text:(NSString *)text
{
    NSString *lineString;
    NSArray * arrLines = (NSArray *)CTFrameGetLines(frame);
    NSInteger count = [arrLines count];
    CGPoint points[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
//    static NSString *ellipsis = @"...";
    [self setNeedsDisplay];
    if (count > 1) {
        for (int i = 0; i < count; i ++) {
            CTLineRef line = (__bridge CTLineRef)arrLines[i];
            CFRange cfRange = CTLineGetStringRange(line);
            NSRange tmpRange = NSMakeRange(cfRange.location, cfRange.length);
            if (tmpRange.length) {
                NSString *string = [text substringWithRange:tmpRange];
                // 大小写
                if ([[string lowercaseString] containsString:[keyword lowercaseString]]) {
                    //                BOOL firstLine = i==0 ? true : false;
                    //                BOOL lastLine = (i+1)==count ? true : false;
                    //                NSString *beginWord;
                    //                NSRange keywordRange = [string rangeOfString:keyword];
                    //                if (firstLine == false) {
                    //                    // 不是在前三位
                    //                    if (string.length > ellipsis.length && keywordRange.location > ellipsis.length) {
                    //                        beginWord = [string substringWithRange:NSMakeRange(ellipsis.length-1, string.length-ellipsis.length)];
                    //                        string = [NSString stringWithFormat:@"%@%@",ellipsis,beginWord];
                    //                    }
                    //                }
                    //                if (lastLine==false) {
                    //                    // 不是在后三位
                    //                    if (string.length > ellipsis.length) {
                    //                        if ((keywordRange.location + keyword.length) < (string.length-keywordRange.length)) {
                    //                            beginWord = [string substringWithRange:NSMakeRange(0, string.length-ellipsis.length)];
                    //                            string = [NSString stringWithFormat:@"%@%@",beginWord,ellipsis];
                    //                        }
                    //                    }
                    //                }
                    lineString = string;
                    break;
                }
            }
        }
    }else{
        lineString = text;
    }
    
    return lineString;
}

- (NSMutableAttributedString *)highlightKeyword:(NSString *)keyword mainWord:(NSString *)mainWord
{
    NSRange range = [[mainWord lowercaseString] rangeOfString:[keyword lowercaseString]];
    if (mainWord.length) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:mainWord];
        [attr setAttributes:@{NSForegroundColorAttributeName: HEXCOLOR(0x0076da)} range:range];
        return attr;
    }
    return nil;
}


- (void)textHeigLightKeyWord:(NSString *)keyWord {
    
    [self textHeigLightKeyWord:keyWord color:[UIColor redColor]];
}
- (void)textHeigLightKeyWord:(NSString *)keyWord color:(UIColor *)color {
    NSString *keyword = keyWord;
    NSString *result = self.text.length==0?@"":self.text;
    // 设置标签文字
    NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString:result];
    // 获取标红的位置和长度
    NSRange range = [result rangeOfString:keyword];
    // 设置标签文字的属性
    [attrituteString setAttributes:@{NSForegroundColorAttributeName : color} range:range];
    // 显示在Label上
    self.attributedText = attrituteString;
}


@end
