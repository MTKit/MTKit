//
//  NSString+MTDateFormat.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/8/5.
//  Copyright © 2016年 MaiTian. All rights reserved.
//

#import "NSString+MTDateFormat.h"
#import "NSDate+Extension.h"
#import "NSDate+Time.h"

@implementation NSString (MTDateFormat)

- (NSString * _Nullable)mt_formatTimestampType1
{
    NSString *ret;
    NSString *suffix;
    NSInteger differenceCount = 0;
    if (self.length) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSUInteger unitFlags =
        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
        
        NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
        NSDateComponents *selfComponents = [calendar components:unitFlags fromDate:date];
        
        NSInteger diffYear = nowComponents.year - selfComponents.year;
        NSInteger diffMonth = nowComponents.month - selfComponents.month;
        NSInteger diffDay = nowComponents.day - selfComponents.day;
        NSInteger diffHour = nowComponents.hour - selfComponents.hour;
        NSInteger diffMin = nowComponents.minute - selfComponents.minute;
        
        if (diffYear == diffMonth) {
            if (diffMonth  == diffDay) {
                if (diffDay == diffHour) {
                    if (diffHour == diffMin) {
                        if (diffMin == 0) {
                            ret = @"刚刚";
                        }
                    }
                }
            }
        }
        
        if (ret.length == 0) {
            ret = stringWithDiffCount(nowComponents.year,nowComponents.month, selfComponents.year,selfComponents.month, 12, @"xx年前", @"xx个月前");
        }
        if (ret.length == 0) {
            ret = stringWithDiffCount(nowComponents.month,nowComponents.day, selfComponents.month,selfComponents.day, 30, @"xx个月前",  @"xx天前");
        }
        if (ret.length == 0) {
            ret = stringWithDiffCount(nowComponents.day,nowComponents.hour, selfComponents.day, selfComponents.hour,24, @"xx天前", @"xx小时前");
        }
        if (ret.length == 0) {
            ret = stringWithDiffCount(nowComponents.hour,nowComponents.minute, selfComponents.hour,selfComponents.minute, 60, @"xx小时前", @"xx分钟前");
        }
        if (ret.length == 0) {
            ret = stringWithDiffCount(nowComponents.minute,nowComponents.second, selfComponents.minute,selfComponents.second, 60, @"xx分钟前", @"刚刚");
        }
        
        if (suffix.length && differenceCount) {
            ret = [suffix stringByReplacingOccurrencesOfString:@"xx" withString:[NSString stringWithFormat:@"%zd",differenceCount]];
        }
    }

    return ret;
}

- (NSString * _Nullable)mt_formatTimestampType2
{
    NSString *ret = @"";
    if (self.length) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
        if (date) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags =
            NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;

            //手机当前时间
            NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
            //传过来的时间
            NSDateComponents *selfComponents = [calendar components:unitFlags fromDate:date];
            
            NSInteger diffYear = nowComponents.year - selfComponents.year;
            NSInteger diffMonth = nowComponents.month - selfComponents.month;
            NSInteger diffDay = nowComponents.day - selfComponents.day;

            if (diffYear == 0) {
                if (diffMonth  == 0) {
                    if (diffDay == 0) {
                        ret = @"今天";
                    } else if (diffDay == 1) {
                        ret = @"昨天";
                    }
                }
                if (diffMonth == 1) {
                    if ([date isYESTERDAY]) {
                        return @"昨天";
                    }
                }
            }

            if (ret.length == 0) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                ret = [dateFormatter stringFromDate:date];
            }
        }
    }
    return ret;
}

id stringWithDiffCount(NSInteger,NSInteger,NSInteger,NSInteger,NSInteger,NSString *,NSString *);

id stringWithDiffCount(NSInteger nowComponents, NSInteger nowNextLevelCom,NSInteger selfComponents,NSInteger selfNextLevelCom,NSInteger maxUnitCount,NSString *suffixString,NSString *suffixNextLevel)
{
    return [NSString _stringWithNowComponents:nowComponents nowNextLevelCom:nowNextLevelCom selfComponents:selfComponents selfNextLevelCom:selfNextLevelCom unitCount:maxUnitCount suffix:suffixString suffixNextLevel:suffixNextLevel];
}

+ (NSString * _Nullable)_stringWithNowComponents:(NSInteger)nowComponents
                                 nowNextLevelCom:(NSInteger)nowNextLevelCom
                                  selfComponents:(NSInteger)selfComponents
                                selfNextLevelCom:(NSInteger)selfNextLevelCom
                                   unitCount:(NSInteger)maxUnitCount
                                      suffix:(NSString *)suffixString
                                 suffixNextLevel:(NSString *)suffixStringNextLevel

{
    NSString *ret = @"";
    NSString *suffix;
    NSInteger differenceCount = 0;
    NSInteger diff = nowComponents - selfComponents;
    
    if(diff == 0) {
        ret = @"";
    }else if(diff == 1 && (maxUnitCount + nowNextLevelCom - selfNextLevelCom) < maxUnitCount) {
        // 一个单位之内, 比如天,月,日
        differenceCount = maxUnitCount + nowNextLevelCom - selfNextLevelCom;
        suffix = suffixStringNextLevel;
    }else{
        // 相差在一个单位以上
        differenceCount = diff;
        suffix = suffixString;
    }
    
    if (differenceCount > 0 && suffix.length) {
        ret = [suffix stringByReplacingOccurrencesOfString:@"xx" withString:[NSString stringWithFormat:@"%zd",differenceCount]];
    }
    return ret;
}

- (NSString *)mt_formatTimestampType3
{
    NSString *ret = @"";
    if (self.length) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
        if (date) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags =
            NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
            | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
            NSDateComponents *nowComponents = [calendar components:unitFlags
                                                          fromDate:[NSDate date]];
            NSDateComponents *selfComponents = [calendar components:unitFlags
                                                           fromDate:date];
            
            NSInteger diffYear = nowComponents.year - selfComponents.year;
            NSInteger diffMonth = nowComponents.month - selfComponents.month;
            NSInteger diffDay = nowComponents.day - selfComponents.day;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setLocale:[NSLocale currentLocale]];
            
            if (diffYear == 0) {
                if (diffMonth  == 0) {
                    if (diffDay == 0) {
                        [dateFormatter setDateFormat:@"HH:mm"];
                        ret = [dateFormatter stringFromDate:date];
                    }else if (diffDay == 1) {
                        [dateFormatter setDateFormat:@"HH:mm"];
                        ret = [dateFormatter stringFromDate:date];
                        ret = [NSString stringWithFormat:@"昨天 %@",ret];
                    }else if (diffDay < 7) {
                        [dateFormatter setDateFormat:@"EEEE HH:mm"];
                        ret = [dateFormatter stringFromDate:date];
                    }
                }
            }

            if (ret.length == 0) {
                [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
                ret = [dateFormatter stringFromDate:date];
            }
        }
    }
    return ret;
}

- (NSString *)mt_formatTimestampType4{
    NSString *timeStamp = self;
    NSString *compareStamp = [NSDate dateConvertTimeStampWithTimeString:[NSDate currentLocationTimeType:CurrentTimeTypeNormal]];
    
    
    if(!self.length){
        return [NSDate dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd"];
    }
    if(timeStamp.length != 10){
        timeStamp = [timeStamp substringWithRange:NSMakeRange(0, timeStamp.length - 3)];
    }
    
    if(compareStamp.length != 10){
        compareStamp = [compareStamp substringWithRange:NSMakeRange(0, compareStamp.length - 3)];
    }
    
    // 1.相比的时间1
    NSDate *fromDate = [NSDate dateConvertTimeStamp:timeStamp];
    
    // 2.相比的时间2
    NSDate *locateDate = [NSDate dateConvertTimeStamp:compareStamp];
    
    if([fromDate timeIntervalSinceReferenceDate] > [locateDate timeIntervalSinceReferenceDate]) return [NSDate dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd"];
    
    NSInteger lTime = fabs([locateDate timeIntervalSinceReferenceDate] - [fromDate timeIntervalSinceReferenceDate]);
    
    NSInteger iSeconds = lTime % 60;
    NSInteger iMinutes = (lTime / 60) % 60;
    NSInteger iHours   = lTime/3600;
    
    if([fromDate isYEAR]){ // 如果是今年
        if([fromDate isMONTH]){ // 如果是这个月
            
            // 如果不是 今天,  不是 昨天 , 不是 前天
            if(![fromDate isTODAY] && ![fromDate isYESTERDAY] && ![fromDate isBEFOREYESTERDAY]){
                return [NSDate dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd"];
            }else{
                if([fromDate isTODAY]){ // 是今天
                    
                    NSLog(@"leisongpo time : %@",fromDate);
                    
                    if(iHours > 0 && iHours < 24){
                        return [NSString stringWithFormat:@"%zd小时前",iHours];
                    }
                    
                    if(iMinutes >=1 && iMinutes < 60){
                        return [NSString stringWithFormat:@"%zd分钟前",iMinutes];
                    }
                    
                    if(iSeconds >= 0 && iSeconds <= 60){
                        return @"刚刚";
                    }
                }
                
                if([fromDate isYESTERDAY]){ // 是昨天
                    return @"昨天";
                }
                
                if([fromDate isBEFOREYESTERDAY]){ // 是前天
                    return @"前天";
                }
            }
        }else{ // 如果不是这个月
            
            // 如果 不是 前天  && 不是 昨天
            if(![fromDate isYESTERDAY] && ![fromDate isBEFOREYESTERDAY]){
                return [NSDate dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd"];
            }else{ // 昨天  和 前天
                if([fromDate isYESTERDAY]){ // 是昨天
                    return @"昨天";
                }
                
                if([fromDate isBEFOREYESTERDAY]){ // 是前天
                    return @"前天";
                }
            }
        }
    }else{ // 不是今年
        return [NSDate dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd"];
    }
    
    return [NSDate dateConvertTimeStringWithTimeStamp:timeStamp format:@"YYYY-MM-dd"];
}

- (NSString *)mt_formatTimestampType5
{
    NSString *ret = @"";
    if (self.length) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
                
        if (date) {

            NSCalendar *calendar = [NSCalendar currentCalendar];
            if (@available(iOS 8.0, *)) {
                if ([calendar isDateInYesterday:date])
                {
                    ret = @"昨天";
                }
                else if([calendar isDateInToday:date])
                {
                    // 今天
                    [dateFormatter setDateFormat:@"HH:mm"];
                    ret = [dateFormatter stringFromDate:date];
                }
                else if([date isInSevenDays])
                {
                    // 7天内
                    [dateFormatter setDateFormat:@"EEEE"];
                    ret = [dateFormatter stringFromDate:date];
                }
            } else {
                // Fallback on earlier versions
            }
            
//            if ([[NSDate date] timeIntervalSinceDate:date] < 0)
//            {
//                ret = nil;
//            }
            
            if (ret.length == 0) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                ret = [dateFormatter stringFromDate:date];
            }
        }
    }
    return ret;
}

- (NSString *)mt_formatTimestampType6
{
    NSString *ret = @"";
    if (self.length) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"MM月dd日"];
        ret = [dateFormatter stringFromDate:date];
    }
    return ret;
}

- (NSString *)mt_formatTimestampType7
{
    NSString *ret = @"";
    if (self.length) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        
        if (date) {
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            if ([calendar isDateInYesterday:date])
            {
                // 昨天
                [dateFormatter setDateFormat:@"HH:mm"];
                ret = [dateFormatter stringFromDate:date];
                ret = [NSString stringWithFormat:@"昨天 %@",ret];
            }
            else if([calendar isDateInToday:date])
            {
                // 今天
                [dateFormatter setDateFormat:@"HH:mm"];
                ret = [dateFormatter stringFromDate:date];
            }
            else if([date isInSevenDays])
            {
                // 7天内
                [dateFormatter setDateFormat:@"EEEE HH:mm"];
                ret = [dateFormatter stringFromDate:date];
            }
            
            if ([[NSDate date] timeIntervalSinceDate:date] < 0)
            {
                ret = nil;
            }
            
            if (ret.length == 0) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                ret = [dateFormatter stringFromDate:date];
            }
        }
    }
    return ret;
}

- (NSString *)mt_formatTimestampType8
{
    NSString *ret = @"";
    if (self.length) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        
        if (date) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"M月dd日"];
            ret = [dateFormatter stringFromDate:date];
        }
    }
    return ret;
}

/**规则--
 1. 今天的显示今天的具体时间 具体到分  例如 8：00
 2. 昨天的显示 昨天 + 时间          例如 昨天 8：00
 3. 其他的显示  日期 2017-01-12
 */
- (NSString *)mt_formatTimestampType9{

    NSString *ret = @"";
    if (self.length) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
        if (date) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags =
            NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
            //手机当前时间
            NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
            //传过来的时间
            NSDateComponents *selfComponents = [calendar components:unitFlags fromDate:date];

            NSInteger diffYear = nowComponents.year - selfComponents.year;
            NSInteger diffMonth = nowComponents.month - selfComponents.month;
            NSInteger diffDay = nowComponents.day - selfComponents.day;

            if (diffYear == 0) {
                if (diffMonth  == 0) {
                    if (diffDay == 0) {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"HH:mm"];
                        ret = [dateFormatter stringFromDate:date];
                        return [NSString stringWithFormat:@"%@",ret];
                    } else if (diffDay == 1) {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"HH:mm"];
                        ret = [dateFormatter stringFromDate:date];
                        return [NSString stringWithFormat:@"昨天 %@",ret];
                    }
                }
                if (diffMonth == 1) {
                    if ([date isYESTERDAY]) {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"HH:mm"];
                        ret = [dateFormatter stringFromDate:date];
                        return [NSString stringWithFormat:@"昨天 %@",ret];
                    }
                }
            }

            if (ret.length == 0) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                ret = [dateFormatter stringFromDate:date];
            }
        }
    }
    return ret;
}

- (NSString *)mt_formatTimestampType10
{
    NSTimeInterval time = 0;
    if (self.length == 10) {
        time = [self doubleValue];
    }else{
        time = [self doubleValue] / 1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *ret = [dateFormatter stringFromDate:date];
    return ret;
}

- (NSString *)mt_formatTimestampType11
{
    NSTimeInterval time = 0;
    if (self.length == 10) {
        time = [self doubleValue];
    }else{
        time = [self doubleValue] / 1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *ret = [dateFormatter stringFromDate:date];
    return ret;
}


/**
 规则--
 1. 今天的显示今天的具体时间 具体到分  例如 8：00
 2. 昨天的显示 昨天           例如 昨天
 3. 其他的显示  日期 2017-01-12
 */
- (NSString *)mt_formatTimestampType12{

    NSString *ret = @"";
    if (self.length) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
        if (date) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags =
            NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
            //手机当前时间
            NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
            //传过来的时间
            NSDateComponents *selfComponents = [calendar components:unitFlags fromDate:date];

            NSInteger diffYear = nowComponents.year - selfComponents.year;
            NSInteger diffMonth = nowComponents.month - selfComponents.month;
            NSInteger diffDay = nowComponents.day - selfComponents.day;

            if (diffYear == 0) {
                if (diffMonth  == 0) {
                    if (diffDay == 0) {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"HH:mm"];
                        ret = [dateFormatter stringFromDate:date];
                        return [NSString stringWithFormat:@"%@",ret];
                    } else if (diffDay == 1) {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"HH:mm"];
                        ret = [dateFormatter stringFromDate:date];
                        return [NSString stringWithFormat:@"昨天 %@",ret];
                    }
                }
                if (diffMonth == 1) {
                    if ([date isYESTERDAY]) {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"HH:mm"];
                        ret = [dateFormatter stringFromDate:date];
                        return [NSString stringWithFormat:@"昨天"];
                    }
                }
            }

            if (ret.length == 0) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                ret = [dateFormatter stringFromDate:date];
            }
        }
    }
    return ret;
}

/**
 规则--
 1. 星期几
 */
- (NSString * _Nullable)mt_formatTimestampType13 {

    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];

    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:newDate];

    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

@end

