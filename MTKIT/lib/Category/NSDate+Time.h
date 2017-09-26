//
//  NSDate+Time.h
//  testMTKiy
//
//  Created by LuKane on 2016/12/21.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CurrentTimeType){
    CurrentTimeTypeNormal,    // 2016-12-21 18:37:23  - 正常
    CurrentTimeTypeSlash ,    // 2016/12/21 18:37:23
    CurrentTimeTypeThin  ,    // 20161221183723       - 紧凑型
    CurrentTimeTypeTimeStamp ,// - 时间戳
};

typedef NS_ENUM(NSInteger ,CurrentTimeDistance){
    CurrentTimeDistanceNormal,      // 刚刚 ,几分钟,几小时,几天,几个月,几年
    CurrentTimeDistanceLess        // 刚刚, 几分钟,几小时,昨天,前天, 日期
};

@interface NSDate (Time)

/**
 获取 当前 时间

 @param timeType 时间类型 -- 1.正常类型  2.紧凑型  3.时间戳
 @return 字符串
 */
+ (NSString *)currentLocationTimeType:(CurrentTimeType)timeType;

/**
 根据 自定义format 获取当前时间

 @param format 时间格式
 @return 时间字符串
 */
+ (NSString *)currentLocationTimeWithFormat:(NSString *)format;

/**
 将 时间字符串 转成 时间戳

 @param timeString 时间字符串
 @return 时间戳
 */
+ (NSString *)dateConvertTimeStampWithTimeString:(NSString *)timeString;

/**
 将 时间戳  转成 时间字符串

 @param timeStamp 时间戳
 @return 时间字符串
 */
+ (NSString *)dateConvertTimeStringWithTimeStamp:(NSString *)timeStamp;


/**
 将 时间戳 转成 时间字符串

 @param timeStamp 时间戳
 @param format 时间类型
 @return 时间字符串
 */
+ (NSString *)dateConvertTimeStringWithTimeStamp:(NSString *)timeStamp format:(NSString *)format;

/**
 根据传入的时间戳 来计算 距离这个时间是多久以前的 , 例如:刚刚,1分钟前,1小时前, 1个月前,1年前

 @param timeStamp 时间戳
 @param CurrentTimeDistanceType 类型 CurrentTimeDistance 数组 : 刚刚,分钟,小时,月,年
 @return 返回所得到的 类型
 */
+ (NSString *)dateTimeDistanceCurrentWithTimeStamp:(NSString *)timeStamp
                        currentTimeDistanceType:(CurrentTimeDistance )CurrentTimeDistanceType;

/**
 根据传入的两个时间戳 来计算 距离 是多久以前的 , 例如:刚刚,1分钟前,1小时前, 1个月前,1年前

 @param timeStamp 时间戳1
 @param compareStamp 时间戳2
 @param CurrentTimeDistanceType 类型 CurrentTimeDistance 数组 : 刚刚,分钟,小时,月,年
 @return 返回所得到的 类型
 */
+ (NSString *)dateTimeDistanceFirstWithTimeStamp:(NSString *)timeStamp
                                         compare:(NSString *)compareStamp
                         currentTimeDistanceType:(CurrentTimeDistance )CurrentTimeDistanceType;

/**
 将 时间戳转成 NSDate

 @param timeStamp 时间戳
 @return 返回转好的 NSDate
 */
+ (NSDate *)dateConvertTimeStamp:(NSString *)timeStamp;

/**
 将 普通时间转成 NSDate`

 @param timeString 普通时间
 @return 返回转好的 NSDate
 */
+ (NSDate *)dateConvertTimeString:(NSString *)timeString;

- (BOOL)isTODAY;    // 是否是 今天
- (BOOL)isTOMMORROW;// 是否是 明天
- (BOOL)isYESTERDAY;// 是否是 昨天
- (BOOL)isBEFOREYESTERDAY;//是否为前天
- (BOOL)isMONTH;    // 是否是 这月
- (BOOL)isYEAR;     // 是否是 今年
- (BOOL)isNextYEAR; // 是否是 明年
- (BOOL)isLastYEAR; // 是否是 去年


@end
