//
//  Toast.m
//  蓝桥播报
//
//  Created by Yock Deng on 15/7/9.
//  Copyright (c) 2015年 蓝桥. All rights reserved.
//

#import "Toast.h"
#import "MTSingleton.h"
#import "MTMacro.h"
//定义一个静态变量用于接收实例对象，初始化为nil
static Toast *singleInstance=nil;

@interface Toast ()

@property (nonatomic,assign,getter=isKeyboardShowing) BOOL keyboardShowing;

@end

@implementation Toast
SYNTHESIZE_SINGLETON_FOR_CLASS(Toast)

- (void)start
{

}

+ (Toast *)shareToast
{
    return [self sharedInstance];
}
- (instancetype)init
{
    if (self = [super init]) {
        SetWeakObjectFor(self);
        [MTNotificationCenter addObserverForName:UIKeyboardDidShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            weakObject.keyboardShowing = true;
        }];
        [MTNotificationCenter addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            weakObject.keyboardShowing = false;
        }];
    }
    return self;
}

- (void)dealloc
{
    [MTNotificationCenter removeObserver:self];
}

/*
 
 */

-(void)makeText:(NSString *)text aDuration:(int)duration{
    if ([text isKindOfClass:[NSString class]] == false) {
        return ;
    }
    if (text.length == 0) {
        return ;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideToast) object:nil];
        _text=text;
        _duration=duration;
        [self show];
        [self performSelector:@selector(hideToast) withObject:nil afterDelay:duration];
    });
}
-(Toast *)makeText:(NSString *)text{
    _text=text;
    return singleInstance;
}
-(Toast *)makeDuration:(int)duration{
    _duration=duration;
    return singleInstance;
}

-(void)makeCenterText:(NSString *)text aDuration:(int)duration
{
    _text=text;
    _duration=duration;
    [self show];
    _toastView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height*0.5);
}

-(void)show{
    if (!_viewIsShow) {
        _viewIsShow=YES;
        UIFont *font=[UIFont systemFontOfSize:16];
        
        if (_lbMsg == nil) {
            _lbMsg=[[UILabel alloc] initWithFrame:CGRectZero];
            _lbMsg.font=font;
            _lbMsg.textColor=[UIColor whiteColor];
            _lbMsg.numberOfLines=0;
        }
        _lbMsg.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        _lbMsg.text=_text;
        
        
        
        if (_toastView == nil) {
            _toastView= [[UIView alloc] initWithFrame:CGRectZero];
            [_toastView addSubview:_lbMsg];
            _toastView.backgroundColor=[UIColor blackColor];
            _toastView.alpha=0.8f;
            _toastView.layer.cornerRadius = 5;
            _toastView.layer.masksToBounds=YES;
        }
        
        
        id <UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:_toastView];
    }else{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideToast) object:nil];
        _lbMsg.text=_text;
    }
    
    CGSize size = [_lbMsg sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, 0)];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    _lbMsg.frame = rect;
    _toastView.frame = CGRectMake(0, 0, rect.size.width + 20, rect.size.height + 20);
    
    
    if (self.isKeyboardShowing) {
        _toastView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    }else{
        _toastView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height*0.85);
    }
    
    _lbMsg.center = CGPointMake(_toastView.frame.size.width / 2, _toastView.frame.size.height / 2);
    
    [self performSelector:@selector(hideToast) withObject:nil afterDelay:_duration];
}

- (void)hide
{
    [self hideToast];
}

-(void)hideToast{
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideToast) object:nil];
        _viewIsShow=NO;
        [_toastView removeFromSuperview];
    });
}

@end
