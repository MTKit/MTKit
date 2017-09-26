//
//  MTRETool.h
//  MTPublicCell
//
//  Created by HaoSun on 16/12/12.
//  Copyright © 2016年 MaiTian. All rights reserved.
//  Regular Expression

#import <Foundation/Foundation.h>

@interface MTRETool : NSObject



#pragma mark- 基本类型验证1

/**1.1整形*/
+ (BOOL)isPureInt:(NSString*)string;

/**1.2浮点型*/
+ (BOOL)isPureFloat:(NSString*)string;

/**1.3中文验证*/
+ (BOOL)isChinese:(NSString*)chinese;


#pragma mark-  信息验证2

/**2.1邮箱*/
+ (BOOL)isEmail:(NSString *)email;



/**2.2url验证*/
+ (BOOL)isURL:(NSString*)url;

/**2.3手机号码验证*/
+ (BOOL)isMobile:(NSString *)mobile;


/**2.4车牌号验证*/
+ (BOOL)isCarNo:(NSString *)carNo;


/**2.5车型验证*/
+ (BOOL)isCarType:(NSString *)CarType;

/**2.6匹配邮政编码*/
+ (BOOL)isPostcode:(NSString *)string;

/**2.7匹配ip地址*/
+ (BOOL)isipAddress:(NSString *)string;

/**2.8匹配MAC地址*/
+ (BOOL)ismacAddress:(NSString *)string;

#pragma mark - 用户信息验证

/**3.1用户名*/
+ (BOOL)isUserName:(NSString *)name;


/**3.2密码验证*/
+ (BOOL)isPassword:(NSString *)passWord;


/**3.3昵称验证*/
+ (BOOL)isNickname:(NSString *)nickname;


/**3.4身份证号验证*/
+ (BOOL)isIDCardNumber:(NSString *)IDCardNumber;

@end
