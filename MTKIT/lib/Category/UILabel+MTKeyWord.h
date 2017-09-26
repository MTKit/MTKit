//
//  UILabel(MTKeyWord).h
//  CoreText
//
//  Created by 鲁志刚 on 16/7/27.
//  Copyright © 2016年 MaiTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(MTKeyWord)

- (NSAttributedString *)keyLineWithKeyword:(NSString *)keyword;

- (NSMutableAttributedString *)highlightKeyword:(NSString *)keyword mainWord:(NSString *)mainWord;

/**给我一个高亮的颜色-和需要高亮的关键字*/
- (void)textHeigLightKeyWord:(NSString *)keyWord color:(UIColor *)color;

/**关键字标红 -给我一个高亮的颜色-和需要高亮的关键字*/
- (void)textHeigLightKeyWord:(NSString *)keyWord;
@end
