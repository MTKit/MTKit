//
//  UIScrollView+MTScroll.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/17.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "UIScrollView+MTScroll.h"

@implementation UIScrollView (MTScroll)


- (void)mt_scrollOriginYToVisible:(CGFloat)y animated:(BOOL)animated
{
    CGRect rect = CGRectMake(0, y, self.frame.size.width, self.frame.size.height);
    [self scrollRectToVisible:rect animated:animated];
}

@end
