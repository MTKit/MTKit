//
//  MTWebProgressLayer.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/5/12.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


@interface MTWebProgressLayer : CAShapeLayer

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;
@end
