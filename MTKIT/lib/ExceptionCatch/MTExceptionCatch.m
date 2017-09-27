//
//  MTUncaughtException.m
//  MTRealEstate
//
//  Created by HaoSun on 16/12/26.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "MTExceptionCatch.h"
#import <UIKit/UIKit.h>
#import "MTTools_MM.h"

@implementation MTExceptionCatch
#pragma mark -日志

- (void)uncaughtExceptionLog{
    [self carshLog];
}

- (void)carshLog{


#ifdef DEBUG
    /** *  如果已经连接Xcode调试则不输出到文件*/
    if (isatty(STDOUT_FILENO)) {
        return;
    }

    /***  判定如果是模拟器就不输出*/
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model]hasSuffix:@"Simulator"]) {
        return;
    }
#else
    NSLog(@"现在是非Debug模式下不打印");
#endif

    /**=*  将NSLog打印信息保存到Document目录下的Log文件夹下*/
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"Log"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
    if (!fileExists) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:logDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"error = %@",[error localizedDescription]);
        }
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//每次启动都保存一个新的日志文件中
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *logFilePath = [logDirectory stringByAppendingFormat:@"/%@.log",dateStr];

    /***  将log文件输出到文件*/
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a++", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a++", stderr);
    /***  未捕获的Object-C异常日志*/
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

static void UncaughtExceptionHandler(NSException* exception){

    NSString *name = [exception name];
    NSString *reason = [exception reason];
    NSArray *symbols = [exception callStackSymbols];//异常发生时的调用栈
    NSMutableString *strSymbols = [[NSMutableString alloc]init];//将调用栈平成输出日志的字符串
    for (NSString *str in symbols) {
        [strSymbols appendString:str];
        [strSymbols appendString:@"\r\n"];
    }
    /***  将crash日志保存到Document目录下的Log文件夹下*/
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"Log"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logDirectory]) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:logDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"error = %@",[error localizedDescription]);
        }
    }

    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"UncaughtException.log"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];

    NSString *crashString = [NSString stringWithFormat:@",- %@ ->[Uncaught Exception]\r\nName:%@,Reason:%@\r\n[Fe Symbols Start]\r\n%@[Fe Symbols End]\r\n\r\n %@\n %@\n %@\n",dateStr,name,reason,strSymbols,[MTTools_MM phoneNumber],@"",@""];

    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }

    /**把错误信息上传到库里面*/

    /***  把错误日志发送到邮箱*/
    //    NSString *urlStr = [NSString stringWithFormat:@"mailto://821339163@qq.com?subject=bug&body=感谢您的配合错误详情:%@",crashString];
    //    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    [[UIApplication sharedApplication]openURL:url];
}

@end
