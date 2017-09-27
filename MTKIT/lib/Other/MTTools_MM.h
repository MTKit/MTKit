//
//  MTTools_MM.h
//  MTRealEstate
//
//  Created by HaoSun on 16/7/29.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//  工具类啊工具类～～～

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MTTools_MM : NSObject

/**
 *  通过时间戳获取当前时间戳的  年份
 */
+ (NSString *)getYearFromStamp:(NSString *)stamp;

/**
 *  通过时间戳获取当前时间戳的  月份
 */
+ (NSString *)getMonthFromStamp:(NSString *)stamp;


/**
 *  通过时间戳获取当前时间戳的  日子
 */
+ (NSString *)getDayFromStamp:(NSString *)stamp;

//获取系统verson
+ (NSString *)getVerson;

//获取build号
+ (NSString *)getBuild;

//获取设备所有者的名称
+ (NSString *)getDeviceName;
//获取设备的类别
+ (NSString *)getDeviceModel;
//获取本地化版本
+ (NSString *)getDevicelocaLizedModel;
//获取当前运行的系统
+ (NSString *)getDevicelocaSystemName;
//获取当前系统的版本
+ (NSString *)getDevicelocaSystemVersion;
//设备唯一id
+ (NSString *)getDeviceUUIDString;
//获取app名字
+ (NSString *)getAppName;
//头像/图片点击产生大图
+ (NSString *)cutStringWithPath:(NSString *)path;
//获取手机号
+(NSString *)phoneNumber;
//通过type返回类型
+ (NSString *)statusWithType:(NSInteger)type;

/**
 收起键盘
 */
+(void)keyboardRetracting;

/**
 * 获取导航栏颜色
 */
+ (UIColor *)getNavColor;
/**
 * 获取菩提模块色值- 比navcolor 透明度 *0.8
 */
+ (UIColor *)getPTColor;
@end
