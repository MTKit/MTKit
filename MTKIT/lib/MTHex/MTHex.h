//
//  MTHex.h
//  MTRealEstate
//
//  Created by HaoSun on 16/7/26.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTHex : NSObject

//将十进制转化为二进制,设置返回NSString 长度
+ (NSString *)decimalTOBinary:(uint16_t)tmpid backLength:(int)length;

//将十进制转化为十六进制

+ (NSString *)ToHex:(uint16_t)tmpid;

//将16进制转化为二进制
+ (NSString *)getBinaryByhex:(NSString *)hex;

//16 转 10
+ (NSString *)sixteenHexToTenSixHex:(NSString *)sixHex;

//传入userid给出路径头像两位编码
+ (NSString *)headpicStrFromUserId:(NSString *)userId;

@end
