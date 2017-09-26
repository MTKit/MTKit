//
//  UITableViewCell+MTCell.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/7/26.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTableViewIndexView.h"

@interface UITableView (MTCell)

- (NSIndexPath * _Nullable)indexPathForView:(UIView * _Nonnull)view;

- (void)mt_showIndexView;

- (MTTableViewIndexView *_Nonnull)mt_indexView;

@end
