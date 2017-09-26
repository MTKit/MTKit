//
//  NSString+HTML.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/23.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSString+HTML.h"
#import "RegexKitLite.h"

@implementation NSString (HTML)

- (NSAttributedString *)htmlAttributedString
{
    return [self HTMLStringWithImg:true];
}

- (NSAttributedString *)htmlAttributedStringWithNoImg
{
    return [self HTMLStringWithImg:false];
}

- (NSAttributedString *)HTMLStringWithImg:(BOOL)flag
{
    if (self.length) {
        NSString *style = [NSString stringWithFormat:@"%@%f%@",@"<style>img{width:auto;max-width:",[UIScreen mainScreen].bounds.size.width-150,@"!important;px;height:auto;} </style>"];
        
        NSString *newString;
        if (flag == false) {
            NSString *regEx = @"<\\s*img\\s+([^>]*)\\s*>";
            NSString * stringWithoutHTML = [self stringByReplacingOccurrencesOfRegex:regEx withString:@""];
            newString = [NSString stringWithFormat:@"%@%@",style,stringWithoutHTML];
        }else{
            newString = [NSString stringWithFormat:@"%@%@",style,self];
        }
        
        //        NSString *newString = [NSString stringWithString:[self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:@4};
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:[newString dataUsingEncoding:NSUnicodeStringEncoding] options:options documentAttributes:nil error:nil];
        return attrString;
    }
    return nil;
}

- (NSData *)mt_data
{
    return [[[NSString alloc] initWithCString:[self UTF8String] encoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)decodeFromPercentEscapeString: (NSString *) urlStr
{
    NSMutableString *outputStr = [NSMutableString stringWithString:urlStr];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,
                                                      [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
