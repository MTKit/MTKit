//
//  UIControl+MTSwizzle.m
//  MTRealEstate
//
//  Created by HaoSun on 16/6/27.
//  Copyright © 2016年 liusongpo. All rights reserved.
//

#import "UIControl+MTSwizzle.h"

#import <objc/runtime.h>

#import "MTSwizzleTool.h"
#import "MTLogEventDataCenter.h"
#import "FMDBManager.h"
#import "MTStatistics.h"
#import "MTSQLiteManager.h"

@implementation UIControl (MTSwizzle)


+(void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originSEL = @selector(sendAction:to:forEvent:);
        SEL swizzleSEL = @selector(swizzleSendAction:to:forEvent:);
        [MTSwizzleTool MTSwizzleWithClass:[self class]originalSelector:originSEL swizzleSelector:swizzleSEL];

    });
}

- (void)swizzleSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{

    // 1.先执行原来的方法，以防止和类上下文相关的数值
    [self swizzleSendAction:action to:target forEvent:event];

    NSString *selectorName = NSStringFromSelector(action);
    NSString *pathString = [[NSBundle mainBundle]pathForResource:@"MTResource" ofType:@"plist"];
    NSDictionary *plistDic = [NSDictionary dictionaryWithContentsOfFile:pathString];
    // 2.获取某个类的方法列表
    NSDictionary *classMthodDic = plistDic[NSStringFromClass([target class])];
    // 3.获取其中某个方法的参数列表
    NSArray *parameterArray = classMthodDic[selectorName];


    MTLogEventDataCenter *logCenter = [[MTLogEventDataCenter alloc]init];
    NSMutableDictionary *logInfoDic = [NSMutableDictionary dictionary];

    // 4.对已经知道数值的数据进行埋点的处理
    NSMutableDictionary *konwnParaDic = [NSMutableDictionary dictionaryWithDictionary:parameterArray[0]];
    NSString *coValueString = [konwnParaDic objectForKey:@"bn"];
    if ([coValueString containsString:@"&"]) {

        NSArray *conditionValuesArray = [coValueString componentsSeparatedByString:@"&"];

        NSString *conditionString = conditionValuesArray[1];
        NSArray *conditionValues = [conditionString componentsSeparatedByString:@"="];

        // 满足条件
        if (conditionValues[1] == [target valueForKey:conditionValues[0]]) {

            [konwnParaDic setObject:conditionValuesArray[0] forKey:@"bn"];

            // 不满足条件直接返回
        }else{

            return;
        }

    }

    // 5.没有条件则直接处理
    [logInfoDic addEntriesFromDictionary:konwnParaDic];

    // 6.对其余的字符串进行相应的处理
    for (int i = 1; i < parameterArray.count; i ++) {

        NSString * paraString =parameterArray[i];

        if ([paraString containsString:@"&"]) {

            // 这个数值是需要从所在的类获取的
            NSString *valueString = @"";
            NSArray *paraArray = [paraString componentsSeparatedByString:@"&"];
            if ([paraArray[1] isEqualToString:@"zhLogTitle"]) {

                valueString = [self valueForKey:@"zhLogTitle"];

            }else{

                valueString = [target valueForKey:paraArray[1]];

            }
            [logInfoDic setObject:valueString forKey:paraArray[0]];

        }else{

            SEL paraSel = NSSelectorFromString(paraString);
            if ([logCenter respondsToSelector:paraSel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                NSString *valueString = [logCenter performSelector:paraSel withObject:nil];
#pragma clang diagnostic pop
                [logInfoDic setObject:valueString forKey:paraString];
            }
        }
    }

    if ([logInfoDic allValues].count) {

        MTLogEventDataCenter * logInfo = [MTLogEventDataCenter new];
        logInfo.userId = [MTStatistics getCurrUserId];
        logInfo.resourceCode = logInfoDic[@"bn"];
        logInfo.resourceType = 2;
        logInfo.receiveResourceTriggerDate = [MTStatistics getSystemStampMillisecond];
        logInfo.useType = 1;
        logInfo.accessNetworkType = [MTInfoSingle shareInstance].reachability;


        if (logInfo.resourceCode == nil || [logInfo.resourceCode isEqualToString:@""] || [logInfo.resourceCode isEqual:[NSNull null]]) {
            return;
        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
            BOOL res = [MTSQLiteManager insertToTableName:@"Statistics" andObject:logInfo];
            NSLog(@"-------->插入%@",res?@"成功":@"失败");
            NSLog(@"-------->用户id %@,当前控制器 %@,页面资源类型 %ld,%@,始终%ld,网络资源使用类型%ld",logInfo.userId,logInfo.resourceCode,logInfo.resourceType,logInfo.receiveResourceTriggerDate,logInfo.useType,logInfo.accessNetworkType);
#pragma clang diagnostic pop
        }
    }
}

@end
