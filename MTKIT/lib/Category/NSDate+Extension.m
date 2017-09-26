//
//  NSDate+Extension.m
//
//
//  Created by apple on 14/12/13.
//  Copyright (c) 2014年 KNKane. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

///**
// *  计算toDate和self的时间差距
// */
//- (NSDateComponents *)componentsToDate:(NSDate *)toDate
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    return [calendar components:unit fromDate:self toDate:toDate options:0];
//}
//
///**
// *  是否为今年
// */
//- (BOOL)isThisYear
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
//    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
//    return nowYear == selfYear;
//}
//
///**
// *  是否为今天
// */
//- (BOOL)isToday
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    return [calendar components:NSCalendarUnitDay fromDate:[NSDate date].ymd toDate:self.ymd options:0].day == 0;
//}
//
///**
// *  是否为昨天
// */
//- (BOOL)isYesterday
//{
//    // 1.获得系统自带的日历对象
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    // 2.比较2个时间的差距
//    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:self.ymd toDate:[NSDate date].ymd options:0];
//    return cmps.day == 1;
//}
//
///**
// *  是否为明天
// */
//- (BOOL)isTomorrow
//{
//    // 1.获得系统自带的日历对象
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    // 2.比较2个时间的差距
//    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:self.ymd toDate:[NSDate date].ymd options:0];
//    return cmps.day == -1;
//}
//
///**
// *  将一个时间变为只有年月日的时间(时分秒都是0)
// */
//- (NSDate *)ymd
//{
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyy-MM-dd";
//    return [fmt dateFromString:[fmt stringFromDate:self]];
//}

- (BOOL)isInSevenDays
{
    NSDate *anotherDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *anotherComponents = [calendar components:unitFlags fromDate:anotherDate];
    int oneDaySec = 60*60*24;
    if ([anotherDate timeIntervalSince1970] - anotherComponents.hour*60*60 - anotherComponents.minute*60 - anotherComponents.second - oneDaySec*7 - [self timeIntervalSince1970] <= 0) {
        return true;
    }else{
        return false;
    }
}

@end
