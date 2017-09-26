//
//  PHAsset+MT.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/8/24.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (MT)

- (void)mt_requestPathForVideo:(void (^)(NSString *path))resultHandler;

@end
