//
//  UIImage+MTDimensionalCode.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/6/6.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "UIImage+MTDimensionalCode.h"
#import "MTRETool.h"

@implementation UIImage (MTDimensionalCode)

- (BOOL)hasDimensionalCode{
    //长按识别二维码,在长按之前开始识别
    CIImage *ciImage = [CIImage imageWithCGImage:[self CGImage]];
    CIContext *ciContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}]; // 软件渲染
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:ciContext options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];// 二维码识别
    NSArray *features = [detector featuresInImage:ciImage];
    if (features.count) {
        CIQRCodeFeature *feature = [features firstObject];
        if (feature.messageString.length) {
            return ([MTRETool isURL:feature.messageString] && [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:feature.messageString]]);//使用正则判断是否为url
        }
        return NO;
    }
    return NO;
}


- (NSString *)dimensionalCodeUrl{
    CIImage *ciImage = [CIImage imageWithCGImage:[self CGImage]];
    CIContext *ciContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}]; // 软件渲染
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:ciContext options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];// 二维码识别
    NSArray *features = [detector featuresInImage:ciImage];
    if (features.count) {
        CIQRCodeFeature *feature = [features firstObject];
        if (feature.messageString) {
            return feature.messageString;
        }
    }
    return @"";
}

@end
