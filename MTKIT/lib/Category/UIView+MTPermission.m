//
//  UIView+MTPermission.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/9/7.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "UIView+MTPermission.h"
#import "UIView+MTExtension.h"
#import "BaseViewController.h"

@implementation UIView (MTPermission)

- (void)setMTControlWithPageCode:(NSString *)pageString
{
    BaseViewController *controller = (BaseViewController *)[self superController];
    if ([controller isKindOfClass:[BaseViewController class]]) {
        [controller theButtonIsAllowVisitOrNot:self.tag pageCode:pageString];
    }
}

@end
