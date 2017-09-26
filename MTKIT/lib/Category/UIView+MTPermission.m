//
//  UIView+MTPermission.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/9/7.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "UIView+MTPermission.h"
#import "UIView+MTExtension.h"
#import <UIKit/UIKit.h>

@implementation UIView (MTPermission)

- (void)setMTControlWithPageCode:(NSString *)pageString
{
    UIViewController *controller = [self superController];
    if ([controller respondsToSelector:@selector(theButtonIsAllowVisitOrNot:pageCode:)]) {
        @throw [NSException exceptionWithName:@"未完成" reason:@"(UIView + MTPermission)未完成" userInfo:nil];
//        [controller performSelector:@selector(theButtonIsAllowVisitOrNot:pageCode:) withObject:@(self.tag) withObject:pageString];
    }
}

@end
