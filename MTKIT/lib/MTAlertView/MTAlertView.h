//
//  MTAlertView.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/3/31.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MTAlertViewContentNormal = 0,//默认灰色字体
    MTAlertViewContentBlack,//黑色字体
} MTAlertViewContentType;


typedef void(^cancleBtnClick) ();
typedef void(^sureBtnClick) ();


@interface MTAlertView : UIView
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content cancleTitle:(NSString *)cancleTitle sureTitle:(NSString *)sureTitle;

/**
 展示这个页面
 */
- (void)show;

@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) cancleBtnClick cancleBtnAction;
@property (nonatomic, copy) sureBtnClick sureBtnAction;
@property (nonatomic, assign) MTAlertViewContentType contentType;
@end
