//
//  Toast.h
//  蓝桥播报
//
//  Created by Yock Deng on 15/7/9.
//  Copyright (c) 2015年 蓝桥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Toast : NSObject
{
    UIView *_toastView;
    UILabel *_lbMsg;
    BOOL _viewIsShow;
    
    NSTimer *_timer;
    NSString *_text;
    int _duration;
}

#define MTToast(a,b)         [[Toast shareToast] makeText:a aDuration:b];


+(Toast *)shareToast;
-(void)makeText:(NSString *)text aDuration:(int)duration;
-(Toast *)makeText:(NSString *)text;
-(Toast *)makeDuration:(int)duration;
-(void)makeCenterText:(NSString *)text aDuration:(int)duration;

- (void)hide;

- (void)start;

@end
