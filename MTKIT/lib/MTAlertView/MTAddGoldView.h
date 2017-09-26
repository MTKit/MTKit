//
//  MTAddGoldView.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/4/11.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAX_PADDING 10
#define MIN_PADDING 5
#define ZERO_PADDING 0
typedef void(^reduceBtnClick) ();
typedef void(^addBtnClick) ();
typedef void(^cancleBtnClick) ();
typedef void(^sureBtnClick) ();

typedef NS_ENUM(NSInteger,MTGoldType) {
    MTGoldNormal = 1,
    MTGoldPutQuestion,
};

@interface MTAddGoldView : UIView
- (instancetype)initWithChangeGoldNum:(NSInteger)GoldNum type:(MTGoldType)type;//有确认和取消按钮
/**
 展示这个页面-实际上就是添加到 keywindows上
 */
- (void)show;
@property (nonatomic, copy) reduceBtnClick reduceBtnAction;
@property (nonatomic, copy) addBtnClick addBtnAction;

@property (nonatomic, copy) cancleBtnClick cancleBtnAction;
@property (nonatomic, copy) sureBtnClick sureBtnAction;
@property (nonatomic, assign) NSInteger addOfferVal;
@end
