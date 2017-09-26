//
//  PHAsset+MT.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/8/24.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "PHAsset+MT.h"

@implementation PHAsset (MT)

- (void)mt_requestPathForVideo:(void (^)(NSString *path))resultHandler {
    if (self.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:self options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable inf) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            
            NSURL *videoURL = urlAsset.URL;
            NSData *data = [NSData dataWithContentsOfURL:videoURL];
            NSFileManager *fileman = [NSFileManager defaultManager];
            if (videoURL == nil) {
                return ;
            }
            NSString *lastPathComponent = [videoURL lastPathComponent];
            if (lastPathComponent == nil) {
                lastPathComponent = @"";
            }
            NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingPathComponent:lastPathComponent];
            if ([fileman fileExistsAtPath:tmpPath]) {
                [fileman removeItemAtPath:tmpPath error:nil];
            }
            if ([data writeToFile:tmpPath atomically:true]) {
                if (resultHandler) {
                    resultHandler(tmpPath);
                }
            }
        }];
    }
}

@end
