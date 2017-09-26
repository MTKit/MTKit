//
//  NSDate+Time.m
//  testMTKiy
//
//  Created by LuKane on 2016/12/21.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)

+ (NSString *)currentLocationTimeType:(CurrentTimeType)timeType{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    switch (timeType) {
        case CurrentTimeTypeNormal:{
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            return [[NSString alloc] initWithFormat:@"%@",[formatter stringFromDate:currentDate]];
        }
            break;
        case CurrentTimeTypeThin:{
            [formatter setDateFormat:@"YYYYMMddHHmmss"];
            return [[NSString alloc] initWithFormat:@"%@",[formatter stringFromDate:currentDate]];
        }
            break;
        case CurrentTimeTypeSlash:{
            [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
            return [[NSString alloc] initWithFormat:@"%@",[formatter stringFromDate:currentDate]];
        }
            break;
        case CurrentTimeTypeTimeStamp:{
            NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval a = [date timeIntervalSince1970];
            return [NSString stringWithFormat:@"%.0f", a];// 转为字符型
        }
            break;
        default:
            break;
    }
}

+ (NSString *)currentLocationTimeWithFormat:(NSString *)format{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [[NSString alloc] initWithFormat:@"%@",[formatter stringFromDate:currentDate]];
}

+ (NSString *)dateConvertTimeStampWithTimeString:(NSString *)timeString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:timeString];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeStamp;
}

+ (NSString *)dateConvertTimeStringWithTimeStamp:(NSString *)timeStamp{
    return [self dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd hh:mm:ss"];
}

+ (NSString *)dateConvertTimeStringWithTimeStamp:(NSString *)timeStamp format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString *)dateTimeDistanceCurrentWithTimeStamp:(NSString *)timeStamp
                        currentTimeDistanceType:(CurrentTimeDistance)currentTimeDistanceType{
    return [self dateTimeDistanceFirstWithTimeStamp:timeStamp compare:[self dateConvertTimeStampWithTimeString:[self currentLocationTimeType:CurrentTimeTypeNormal]] currentTimeDistanceType:currentTimeDistanceType];
}

+ (NSString *)dateTimeDistanceFirstWithTimeStamp:(NSString *)timeStamp
                                         compare:(NSString *)compareStamp
                         currentTimeDistanceType:(CurrentTimeDistance )CurrentTimeDistanceType{
    
    if(timeStamp.length != 10){
        timeStamp = [timeStamp substringWithRange:NSMakeRange(0, timeStamp.length - 3)];
    }
    
    if(compareStamp.length != 10){
        compareStamp = [compareStamp substringWithRange:NSMakeRange(0, compareStamp.length - 3)];
    }
    
    // 1.相比的时间1
    NSDate *fromDate = [self dateConvertTimeStamp:timeStamp];
    
    // 2.相比的时间2
    NSDate *locateDate = [self dateConvertTimeStamp:compareStamp];
    
    if([fromDate timeIntervalSinceReferenceDate] > [locateDate timeIntervalSinceReferenceDate]) return @"刚刚";
    
    NSInteger lTime = fabs([locateDate timeIntervalSinceReferenceDate] - [fromDate timeIntervalSinceReferenceDate]);
    
    NSInteger iSeconds = lTime % 60;
    NSInteger iMinutes = (lTime / 60) % 60;
    NSInteger iHours   = lTime/3600;
    NSInteger iDays    = lTime/60/60/24;
    NSInteger iMonth   = lTime/60/60/24/30;
    NSInteger iYears   = lTime/60/60/24/365;
    
    
    NSString *tempTime1 = [self dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd-HH:mm:ss"];
    NSString *tempTime2 = [self dateConvertTimeStringWithTimeStamp:compareStamp format:@"YYYY-MM-dd-HH:mm:ss"];
    
    NSArray *array  = [tempTime1 componentsSeparatedByString:@"-"];
    NSArray *array2 = [tempTime2 componentsSeparatedByString:@"-"];
    NSInteger day = [array2[2] integerValue] - [array[2] integerValue];

    switch (CurrentTimeDistanceType) {
        case CurrentTimeDistanceNormal:{
            if (iYears > 1){
                return [NSString stringWithFormat:@"%zd年前",iYears];
            }else if (0 < iMonth && iMonth < 12){
                return [NSString stringWithFormat:@"%zd月前",iMonth];
            }else if (0 < iDays && iDays < 31){
                return [NSString stringWithFormat:@"%zd天前",iDays];
            }else if (0 < iHours && iHours < 24){
                return [NSString stringWithFormat:@"%zd小时前",iHours];
            }else if (0 < iMinutes && iMinutes < 60){
                return [NSString stringWithFormat:@"%zd分钟前",iMinutes];
            }else if(0 <= iSeconds && iSeconds <= 60){
                return @"刚刚";
            }
        }
            break;
        case CurrentTimeDistanceLess:{
            if (iYears > 1){
                return [self dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd"];
            }else if (0 < iMonth && iMonth < 12){
                return [self dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd"];
            }
            
            if(day == 0){
                
                if (0 < iHours && iHours < 24){
                    return [NSString stringWithFormat:@"%zd小时前",iHours];
                }
                
                if (0 < iMinutes && iMinutes < 60){
                    return [NSString stringWithFormat:@"%zd分钟前",iMinutes];
                }
                
                if(0 <= iSeconds && iSeconds <= 60){
                    return @"刚刚";
                }
            }
            if(day == 1){
                return [NSString stringWithFormat:@"昨天"];
            }
            if(day == 2){
                return [NSString stringWithFormat:@"前天"];
            }
            
            if(day < 0){
                if(iDays == 1){
                    return [NSString stringWithFormat:@"昨天"];
                }
                if(iDays == 2){
                    return [NSString stringWithFormat:@"前天"];
                }
            }
            
            return [self dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd"];
        }
            break;
            
        default:
            break;
    }
    return nil;
 // 
}

+ (NSDate *)dateConvertTimeStamp:(NSString *)timeStamp{
    if (timeStamp.length == 10) {
        NSTimeInterval time = [timeStamp doubleValue] + 28800; // 因为时差问题要加8小时 == 28800 sec
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        return date;
    }
    return nil;
}
+ (NSDate *)dateConvertTimeString:(NSString *)timeString{
    NSString *timeStamp = [self dateConvertTimeStampWithTimeString:timeString];
    return [self dateConvertTimeStamp:timeStamp];
}

// 是否是 今天
- (BOOL)isTODAY{
    return [self.currentCalendar components:NSCalendarUnitDay fromDate:self.timeYearMonthDay toDate:[self currentDate].timeYearMonthDay options:0].day == 0;
}
// 是否是 明天
- (BOOL)isTOMMORROW{
    return  [self.currentCalendar components:NSCalendarUnitDay fromDate:self.timeYearMonthDay toDate:[self currentDate].timeYearMonthDay options:0].day == -1;
}
// 是否是 昨天
- (BOOL)isYESTERDAY{
    return  [self.currentCalendar components:NSCalendarUnitDay fromDate:self.timeYearMonthDay toDate:[self currentDate].timeYearMonthDay options:0].day == 1;
}

// 是否是 前天
- (BOOL)isBEFOREYESTERDAY{
    return  [self.currentCalendar components:NSCalendarUnitDay fromDate:self.timeYearMonthDay toDate:[self currentDate].timeYearMonthDay options:0].day == 2;
}
// 是否是 这月
- (BOOL)isMONTH{
    return  [self.currentCalendar components:NSCalendarUnitMonth fromDate:self.timeYearMonthDay toDate:[self currentDate].timeYearMonthDay options:0].month == 0;
}
// 是否是 今年
- (BOOL)isYEAR{
    return  [self.currentCalendar components:NSCalendarUnitYear fromDate:self.timeYearMonthDay toDate:[self currentDate].timeYearMonthDay options:0].year == 0;
}
// 是否是 明年
- (BOOL)isNextYEAR{
    return  [self.currentCalendar components:NSCalendarUnitYear fromDate:self.timeYearMonthDay toDate:[self currentDate].timeYearMonthDay options:0].year == -1;
}
// 是否是 去年
- (BOOL)isLastYEAR{
    return  [self.currentCalendar components:NSCalendarUnitYear fromDate:self.timeYearMonthDay toDate:[self currentDate].timeYearMonthDay options:0].year == 1;
}

/**
 * 时间:年月日
 */
- (NSDate *)timeYearMonthDay{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"YYYY-MM-dd";
    [fmt setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return [fmt dateFromString:[fmt stringFromDate:self]];
}

- (NSDate *)currentDate{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeStamp = [NSString stringWithFormat:@"%.0f", a];
    NSTimeInterval time = [timeStamp integerValue] + 28800; // 因为时差问题要加8小时 == 28800 sec
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:time];
    return date1;
}

- (NSCalendar *)currentCalendar{
    return [NSCalendar currentCalendar];
}

@end
