//
//  MTRETool.m
//  MTPublicCell
//
//  Created by HaoSun on 16/12/12.
//  Copyright © 2016年 MaiTian. All rights reserved.
//  Regular Expression
//  正则表达式
#import "MTRETool.h"
#import "UIKit/UIKit.h"

@implementation MTRETool

#pragma mark- 基本类型验证1

/**1.1整形*/
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

/**1.2浮点型*/
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**1.3中文验证*/
+ (BOOL)isChinese:(NSString*)chinese
{
    NSString *regex = @"^[\u4e00-\u9fa5]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject: chinese];
}


#pragma mark-  信息验证2

/**2.1邮箱*/
+ (BOOL)isEmail:(NSString *)email
{
    NSString *regex = @"^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:email];
}



/**2.2url验证*/
+ (BOOL)isURL:(NSString*)url
{
    NSString *regex = @"[a-zA-z]+://[^\\s]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject: url];
}

/**2.3手机号码验证*/
+ (BOOL)isMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *regex = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:mobile];
}


/**2.4车牌号验证*/
+ (BOOL)isCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


/**2.5车型验证*/
+ (BOOL)isCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}

/**2.6匹配邮政编码*/
+ (BOOL)isPostcode:(NSString *)string{

    NSString *postCodeRegex = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",postCodeRegex];
    return [carTest evaluateWithObject:string];

}
/**2.7匹配ip地址*/
+ (BOOL)isipAddress:(NSString *)string{

    NSString *ipRegex = @"([1-9]{1,3}\\.){3}[1-9]";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ipRegex];
    return [carTest evaluateWithObject:string];
    
}

/**2.8匹配MAC地址*/
+ (BOOL)ismacAddress:(NSString *)string{

    NSString *maxRegex = @"([A-Fa-f0-9]{2}\\:){5}[A-Fa-f0-9]";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",maxRegex];
    return [carTest evaluateWithObject:string];

}

#pragma mark - 用户信息验证

/**3.1用户名*/
+ (BOOL)isUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


/**3.2密码验证*/
+ (BOOL)isPassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


/**3.3昵称验证*/
+ (BOOL)isNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


/**3.4身份证号验证*/
+ (BOOL)isIDCardNumber:(NSString *)IDCardNumber
{
    IDCardNumber = [IDCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([IDCardNumber length] != 18)
    {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd , @"[0-9]{3}[0-9Xx]"];

    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:IDCardNumber])
    {
        return NO;
    }
    int summary = ([IDCardNumber substringWithRange:NSMakeRange(0,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([IDCardNumber substringWithRange:NSMakeRange(1,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([IDCardNumber substringWithRange:NSMakeRange(2,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([IDCardNumber substringWithRange:NSMakeRange(3,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([IDCardNumber substringWithRange:NSMakeRange(4,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([IDCardNumber substringWithRange:NSMakeRange(5,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([IDCardNumber substringWithRange:NSMakeRange(6,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [IDCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [IDCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6
    + [IDCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[IDCardNumber substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}
@end
