//
//  MTWebKitController.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/4/7.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef  NS_ENUM (NSInteger , MTWebKitDismissType){
    MTWebKitDismissPopAll = 0,
    MTWebKitDismissPopPage,
    MTWebKitPop,
};

@interface MTWebKitController : BaseViewController
@property (nonatomic, copy) NSString *urlString;
/**默认为整体退出 push 进入，当点击左上角的返回键，0 = 整体退出 1 = page页面退出*/
@property (nonatomic, assign) MTWebKitDismissType dismissType;
@property (nonatomic, copy) NSString *statuColor;
@property (nonatomic, assign) BOOL moreBtnHidden;//YES是展示 NO 不展示 默认不展示
@property (nonatomic, assign) BOOL pushBtnShow;//当push进来的时候，是否展示右上角更多按钮

@end
