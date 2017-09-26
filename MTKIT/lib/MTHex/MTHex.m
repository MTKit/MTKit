//
//  MTHex.m
//  MTRealEstate
//
//  Created by HaoSun on 16/7/26.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//  进制转换

#import "MTHex.h"

@implementation MTHex

//将十进制转化为二进制,设置返回NSString 长度
+ (NSString *)decimalTOBinary:(uint16_t)tmpid backLength:(int)length{
    NSString *a = @"";
    while (tmpid)
    {
        a = [[NSString stringWithFormat:@"%d",tmpid%2] stringByAppendingString:a];
        if (tmpid/2 < 1)
        {
            break;
        }
        tmpid = tmpid/2 ;
    }

    if (a.length <= length)
    {
        NSMutableString *b = [[NSMutableString alloc]init];;
        for (int i = 0; i < length - a.length; i++)
        {
            [b appendString:@"0"];
        }

        a = [b stringByAppendingString:a];
    }

    return a;

}

//将十进制转化为十六进制

+ (NSString *)ToHex:(uint16_t)tmpid{
    NSString *nLetterValue;
    NSString *str =@"";
    uint16_t ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];

        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }

    }
    return str;
}

//将16进制转化为二进制

+ (NSString *)getBinaryByhex:(NSString *)hex{
    NSMutableDictionary  *hexDic =  [[NSMutableDictionary alloc] initWithCapacity:16];

    [hexDic setObject:@"0000" forKey:@"0"];

    [hexDic setObject:@"0001" forKey:@"1"];

    [hexDic setObject:@"0010" forKey:@"2"];

    [hexDic setObject:@"0011" forKey:@"3"];

    [hexDic setObject:@"0100" forKey:@"4"];

    [hexDic setObject:@"0101" forKey:@"5"];

    [hexDic setObject:@"0110" forKey:@"6"];

    [hexDic setObject:@"0111" forKey:@"7"];

    [hexDic setObject:@"1000" forKey:@"8"];

    [hexDic setObject:@"1001" forKey:@"9"];

    [hexDic setObject:@"1010" forKey:@"A"];

    [hexDic setObject:@"1011" forKey:@"B"];

    [hexDic setObject:@"1100" forKey:@"C"];

    [hexDic setObject:@"1101" forKey:@"D"];

    [hexDic setObject:@"1110" forKey:@"E"];

    [hexDic setObject:@"1111" forKey:@"F"];

    NSString *binaryString = [[NSMutableString alloc] init];

    for (int i=0; i<[hex length]; i++) {

        NSRange rage;

        rage.length = 1;

        rage.location = i;

        NSString *key = [hex substringWithRange:rage];

        //NSLog(@"%@",[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]);

        NSString *tempStr = [NSString stringWithFormat:@"%@",[hexDic objectForKey:key]];

        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,tempStr];

    }

    //NSLog(@"转化后的二进制为:%@",binaryString);

    return binaryString;

}

+ (NSString *)headpicStrFromUserId:(NSString *)userId{

    NSString *needStr = [NSString stringWithFormat:@"%@",[userId substringFromIndex:userId.length-2]];
    NSString *result = [self sixteenHexToTenSixHex:needStr];
    NSInteger tage = result.integerValue%50;
    result = [NSString stringWithFormat:@"%ld",(long)tage];
    return result;
}


+ (NSString *)sixteenHexToTenSixHex:(NSString *)sixHex{

    //*16->10
    NSString * temp10 = [NSString stringWithFormat:@"%lu",strtoul([sixHex UTF8String],0,16)];
    //转成数字
    //int cycleNumber = [temp10 intValue];
    return temp10;
}


@end
