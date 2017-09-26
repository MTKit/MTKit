//
//  MTTools_MM.m
//  MTRealEstate
//
//  Created by HaoSun on 16/7/29.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "MTTools_MM.h"
#import <UIKit/UIKit.h>
#import "sys/utsname.h"
#import <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "NSString+MTDateFormat.h"
#import "FCUUID.h"
#import "UIDevice+FCUUID.h"
#import "UIColor+KNColor.h"
#import <dlfcn.h>
#define MT_APP_COLOR_NAME @"_mtAppColor" //获取颜色
@implementation MTTools_MM

/**
 *  通过时间戳获取当前时间戳的  年份
 */
+ (NSString *)getYearFromStamp:(NSString *)stamp{

    NSRange range = {0,4};
    NSString *yearStr = [[stamp mt_formatTimestampType2] substringWithRange:range];
    return yearStr;
}

/**
 *  通过时间戳获取当前时间戳的  月份
 */
+ (NSString *)getMonthFromStamp:(NSString *)stamp{

    NSRange range = {5,2};
    NSRange rangeTmp = {5,1};
    NSRange rangeSingle = {6,1};
    NSString *monthStr;
    if ([[[stamp mt_formatTimestampType2] substringWithRange:rangeTmp] isEqualToString:@"0"]) {
         monthStr = [[stamp mt_formatTimestampType2] substringWithRange:rangeSingle];
    }else{
        monthStr = [[stamp mt_formatTimestampType2] substringWithRange:range];
    }

    return [NSString stringWithFormat:@"%@%@",monthStr,@"月"];
}


/**
 *  通过时间戳获取当前时间戳的  日子
 */
+ (NSString *)getDayFromStamp:(NSString *)stamp{
    NSRange range = {8,2};
    NSString *dayStr = [[stamp mt_formatTimestampType2] substringWithRange:range];
    return dayStr;
}
//获取系统verson
+ (NSString *)getVerson{

    return [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] ;
}

//获取build号
+ (NSString *)getBuild{

    return [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

//获取设备所有者的名称
+ (NSString *)getDeviceName{

    return [[[UIDevice alloc] init] name];
}
//获取设备的类别
+ (NSString *)getDeviceModel{

    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";

    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";

    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";

    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";

    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";

    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";

    return platform;
}
//获取本地化版本
+ (NSString *)getDevicelocaLizedModel{

    return [[[UIDevice alloc] init] localizedModel];
}
//获取当前运行的系统
+ (NSString *)getDevicelocaSystemName{

    return [[[UIDevice alloc] init] systemName];

}
//获取当前系统的版本
+ (NSString *)getDevicelocaSystemVersion{

    return [[[UIDevice alloc] init] systemVersion];
    
}
//设备唯一id
+ (NSString *)getDeviceUUIDString{

    return [[UIDevice currentDevice] uuid];
    //    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

//获取app名字
+ (NSString *)getAppName{

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

//头像/图片点击产生大图 ,截取路径
+ (NSString *)cutStringWithPath:(NSString *)path{

    NSString *str = [NSString stringWithFormat:@"%@",path];

    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:str.length];

    for (NSInteger i = str.length - 1; i >= 0 ; i--) {
        unichar ch = [str characterAtIndex:i];
        [newString appendFormat:@"%c",ch];
    }

    NSRange startRange = [newString rangeOfString:@"."];
    NSRange endRange = [newString rangeOfString:@"_"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *temp1;
    if (range.length != 1) {
        temp1 = @"";
    }else{
        temp1 = [NSString stringWithFormat:@".%@_",[newString substringWithRange:range]];
    }

    NSString *temp2 = [newString stringByReplacingOccurrencesOfString:temp1 withString:@"."];

    NSMutableString *tempstr = [[NSMutableString alloc] initWithCapacity:temp2.length];

    for (NSInteger i = temp2.length - 1; i >= 0 ; i--) {
        unichar ch = [temp2 characterAtIndex:i];
        [tempstr appendFormat:@"%c",ch];
    }
    
    return tempstr;
    
}


//extern NSString *CTSettingCopyMyPhoneNumber();
+(NSString *)phoneNumber {
//    NSString *number = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
//    return CTSettingCopyMyPhoneNumber();
//    NSString *phone = [MTInfoSingle shareInstance].postName;
    return @"phone";
}

/**
 0：未回答
 1：已回答
 2：已解决
 3：已删除
 */
+ (NSString *)statusWithType:(NSInteger)type{

    switch (type) {
        case 0:
        {
            return @"未回答";
        }
            break;
        case 1:
        {
            return @"已回答";

        }
            break;
        case 2:
        {
            return @"已解决";

        }
            break;
        case 3:
        {
            return @"已删除";
        }
            break;

        default:
            break;
    }

    return [NSString stringWithFormat:@"未知状态%ld",type];
}

+ (void)keyboardRetracting {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

/**
 * 获取导航栏颜色
 */
+ (UIColor *)getNavColor {

    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString *colorStr = [user objectForKey:MT_APP_COLOR_NAME];
    return [UIColor colorWithHexStr:colorStr alpha:1];
}
/**
 * 获取菩提模块色值- 比navcolor 透明度 *0.85
 */
+ (UIColor *)getPTColor {
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString *colorStr = [user objectForKey:MT_APP_COLOR_NAME];
    return [UIColor colorWithHexStr:colorStr alpha:.85];

}
@end
