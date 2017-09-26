//
//  NSString+MTDateFormat.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/5.
//  Copyright © 2016年 MaiTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MTDateFormat)

/**
 *  @return 返回类型: 刚刚, xx分钟前, xx小时前, xx天前, xx小时前, xx个月前, xx年前
 */
- (NSString * _Nullable)mt_formatTimestampType1;
/**
 *  @return 返回类型: 今天, 昨天, yyyy-mm-dd
 */
- (NSString * _Nullable)mt_formatTimestampType2;

/**
 *  @return 群聊消息的时间显示
 */
- (NSString * _Nullable)mt_formatTimestampType3;
/**
 *  毫秒字符串
 *
 *  @return 刚刚, 几分钟前,  几小时前,  昨天,  前天,  日期
 */
- (NSString * _Nullable)mt_formatTimestampType4;
/**
 *  毫秒字符串
 *
 *  @return hh:mm 昨天 星期几 年月日
 */
- (NSString * _Nullable)mt_formatTimestampType5;
/**
 *  mt_formatTimestampType6
 *
 *  @return xx月xx日
 */
- (NSString * _Nullable)mt_formatTimestampType6;
/**
 *  毫秒字符串
 *
 *  @return hh:mm 昨天 HH:mm; 星期几 HH:mm; 年月日 HH:mm;
 */
- (NSString * _Nullable)mt_formatTimestampType7;

/**
 *  毫秒字符串
 *
 *  @return x月x日
 */
- (NSString * _Nullable)mt_formatTimestampType8;

/**
 规则--
 1. 今天的显示今天的具体时间 具体到分  例如 8：00
 2. 昨天的显示 昨天 + 时间          例如 昨天 8：00
 3. 其他的显示  日期 2017-01-12
 */
- (NSString * _Nullable)mt_formatTimestampType9;

/**
 *  xx年xx月xx日 xx:xx
 *
 *  @return xx年xx月xx日 xx:xx
 */
- (NSString * _Nullable)mt_formatTimestampType10;

/**
 *  xx年xx月xx日
 *
 *  @return ex:2017-11-03
 */
- (NSString * _Nullable)mt_formatTimestampType11;


/**
 规则--
 1. 今天的显示今天的具体时间 具体到分  例如 8：00
 2. 昨天的显示 昨天           例如 昨天
 3. 其他的显示  日期 2017-01-12
 */
- (NSString * _Nullable)mt_formatTimestampType12;
/**
 规则--
 1. 星期几
 */
- (NSString * _Nullable)mt_formatTimestampType13;

@end
