//
//  UIScrollView+MTScroll.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/17.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MTScroll)

- (void)mt_scrollOriginYToVisible:(CGFloat)y animated:(BOOL)animated;

@end
