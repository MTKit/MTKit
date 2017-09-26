//
//  UIButton+MTSwizzle.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/4/26.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MTSwizzle)

- (void)mtImg:(UIImage *)img forState:(UIControlState *)state;
/**
 *  Button 权限被拒绝
 */
- (void)mt_setButtonPermissionDenied;
/**
 *  Button 权限没有被禁止
 */
- (void)mt_setButtonPermissionAllow;

@end
