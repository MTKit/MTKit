//
//  MTMacro.h
//  MTKIT
//
//  Created by 鲁志刚 on 2017/9/26.
//  Copyright © 2017年 MTKIT. All rights reserved.
//

#ifndef MTMacro_h
#define MTMacro_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define MTNotificationCenter [NSNotificationCenter defaultCenter]
#define MTMainQueue [NSOperationQueue mainQueue]
#define MTGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define MTUserDefaults [NSUserDefaults standardUserDefaults]

//key windows

#define KEYWindow [[UIApplication sharedApplication].delegate window]

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define MTClassMatch(a,b) [a isKindOfClass:[b class]]

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define SetWeakObjectFor(Object); \
\
__weak typeof(Object)weakObject = Object;

#define GCDdispatch_time(a) dispatch_time(DISPATCH_TIME_NOW, (int64_t)(a * NSEC_PER_SEC))

#pragma mark - 字体
#define MTFONT24 [UIFont systemFontOfSize:24.0f]
#define MTFONT22 [UIFont systemFontOfSize:22.0f]
#define MTFONT20 [UIFont systemFontOfSize:20.0f]
#define MTFONT18 [UIFont systemFontOfSize:18.0f]
#define MTFONT16 [UIFont systemFontOfSize:16.0f]
#define MTFONT15 [UIFont systemFontOfSize:15.0f]
#define MTFONT14 [UIFont systemFontOfSize:14.0f]
#define MTFONT13 [UIFont systemFontOfSize:13.0f]
#define MTFONT12 [UIFont systemFontOfSize:12.0f]
#define MTFONT10 [UIFont systemFontOfSize:10.0f]

#pragma mark - 基本类型
#define TabeleCell_Normal_H 49
#define PADDING 10

#define NAV_H 64
#pragma mark - 常用色值
#define IMP_Color @"#0076DA"
//#define NAV_PTColor @"#2D8BDB"
//#define NAV_PTColor @"#2D8BDB"
//#define NAV_Color @"#0076DA"//导航栏基本色值
#define Tag_Color @"#F56140"//钱和标签色值
#define Gray_Color @"#919191"//灰色色值
#define Segment_Color @"#93CBFB"//segmentColor
#define ASK_Color @"#259A3A"//回答颜色
#define Font_Color @"#333333"//字体颜色
#define Time_Color @"#888888"
#define BgView_Color @"#EFEFF6"
#define kNewBaseView_Color @"#F3F3F5"
#define MTPTLine_Color @"#F5F5F5"
/**
 * 获取系统版本信息
 */
#define IOS_VERSION [UIDevice currentDevice].systemVersion
#define isiOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
/*! 大于8.0 */
#define IOS8x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

/**
 *判断是哪个机型
 */
#define iPhone6P (ScreenWidth  == 414)
#define iPhone6  (ScreenWidth  == 375)
#define iPhone5  (ScreenHeight == 568)
#define iPhone4  (ScreenHeight == 480)
#endif /* MTMacro_h */
