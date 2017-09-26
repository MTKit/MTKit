//
//  MTHeader.h
//  MTKIT
//
//  Created by HaoSun on 2017/9/26.
//  Copyright © 2017年 MTKIT. All rights reserved.
//

#ifndef MTHeader_h
#define MTHeader_h

//key windows
#define KeyWindow [[UIApplication sharedApplication].delegate window]
//颜色
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
//宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/**
 * 获取系统版本信息
 */
#define IOS_VERSION [UIDevice currentDevice].systemVersion
#define isiOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
/*! 大于11.0 */
#define IOS11x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
/*! 大于8.0 */
#define IOS8x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

/**文字字体***/
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

#endif /* MTHeader_h */
