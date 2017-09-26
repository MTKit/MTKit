//
//  UIViewController+MTExtension.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/23.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "UIView+MTExtension.h"

@implementation UIView (MTExtension)

- (UIViewController *)superController
{
    UIView *next = [self superview];
    while (next)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            return (UIViewController*)nextResponder;
        }
        next = next.superview;
    }
    return nil;
}

@end
