//
//  UITableView+NoMessage.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/4/4.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (NoMessage)

@property (nonatomic, strong) UILabel *mt_tipLabel;

- (void)showTipLable:(BOOL)flag;

@end
