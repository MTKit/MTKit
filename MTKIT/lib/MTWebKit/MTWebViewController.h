//
//  MTWebViewController.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/5/11.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "BaseViewController.h"

@interface MTWebViewController : BaseViewController

@property (nonatomic,copy)NSString *url;
@property (nonatomic,assign)NSInteger isFromMessage;//0：否 1:是 2 是来自查工资
@end
