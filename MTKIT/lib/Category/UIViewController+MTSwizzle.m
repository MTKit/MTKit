//
//  UIViewController+MTSwizzle.m
//  MTRealEstate
//
//  Created by HaoSun on 16/6/27.
//  Copyright © 2016年 liusongpo. All rights reserved.
//

#import "UIViewController+MTSwizzle.h"
#import <objc/runtime.h>

#import "Aspects.h"

#import "MTSwizzleTool.h"
#import "MTLogEventDataCenter.h"

@implementation UIViewController (MTSwizzle)



+ (void)load{
    static dispatch_once_t dispatch_once_token;
    dispatch_once(&dispatch_once_token, ^{
        // swizzle the system
        SEL originlSelector = @selector(viewDidLoad);
        SEL newSelector = @selector(swizzleviewviewDidLoad:);
        [MTSwizzleTool MTSwizzleWithClass:[self class] originalSelector:originlSelector swizzleSelector:newSelector];

    });

}

- (void)swizzleviewviewDidLoad:(BOOL)animated{
    NSString *pathString = [[NSBundle mainBundle]pathForResource:@"MTResource" ofType:@"plist"];
    NSDictionary *plistDic = [NSDictionary dictionaryWithContentsOfFile:pathString];
    // 1.获取某个类的方法列表
    NSDictionary *classMthodDic = plistDic[NSStringFromClass([self class])];
    if (classMthodDic == nil) return; // 该类的方法不需要hook

    NSArray *methodNameArray = [classMthodDic allKeys];

    for (NSString *methodString in methodNameArray) {

        __block SEL originalSEL = NSSelectorFromString(methodString);
        // 这里需要判断是否是UIControl的事件，以防止两个地方同时hook，造成重复上传
        BOOL isResponseOriginSEL = [self respondsToSelector:originalSEL];

        NSRange controlActionRange = [methodString rangeOfString:@"ControlAction"];
        BOOL notControlAction = controlActionRange.length == 0 ? YES : NO;
        __weak typeof(self)weakSelf = self;
        if (isResponseOriginSEL && notControlAction) {
            
            [[self class] aspect_hookSelector:originalSEL withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
                __strong typeof(self)strongSelf = weakSelf;
                NSString *selectorName = NSStringFromSelector(originalSEL);
                NSString *pathString = [[NSBundle mainBundle]pathForResource:@"MTResource" ofType:@"plist"];
                NSDictionary *plistDic = [NSDictionary dictionaryWithContentsOfFile:pathString];
                // 2.获取某个类的方法列表
                NSDictionary *classMthodDic = plistDic[NSStringFromClass([strongSelf class])];
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

                    NSInteger conditionValue = [conditionValues[1] integerValue];
                    NSInteger actualValue = [[strongSelf valueForKey:conditionValues[0]] integerValue];

                    // 满足条件
                    if (conditionValue == actualValue ) {

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
                        NSArray *paraArray = [paraString componentsSeparatedByString:@"&"];
                        NSString *valueString = [strongSelf valueForKey:paraArray[1]];
                        if (valueString.length) [logInfoDic setObject:valueString forKey:paraArray[0]];

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

                    logInfo.userId                = [MTStatistics getCurrUserId];
                    logInfo.resourceType          = 2;
                    logInfo.receiveResourceTriggerDate   = [MTStatistics getSystemStampMillisecond];
                    logInfo.useType               = 1;
                    logInfo.accessNetworkType    = [MTInfoSingle shareInstance].reachability;


                    if ([logInfoDic[@"bn"] isEqualToString:@""]) {
                        logInfo.resourceCode = logInfoDic[@"s1"];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
                        BOOL res = [MTSQLiteManager insertToTableName:@"Statistics" andObject:logInfo];
                        NSLog(@"-------->插入%@",res?@"成功":@"失败");
                        NSLog(@"-------->用户id %@,当前控制器 %@,页面资源类型 %ld,%@,始终%ld,网络资源使用类型%ld",logInfo.userId,logInfo.resourceCode,(long)logInfo.resourceType,logInfo.receiveResourceTriggerDate,(long)logInfo.useType,(long)logInfo.accessNetworkType);
#pragma clang diagnostic pop

                    }
                }

            } error:nil];
        }
    }
    [self swizzleviewviewDidLoad:animated];
    
}

@end
