//
//  MTTableViewIndexView.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/8/9.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTableViewIndexViewIndicatorW 38
#define kTableViewIndexViewIndicatorH 31

@interface MTTableViewIndexView : UIView

@property (nonatomic, weak) UITableView *tableView;

- (void)reloadData;

@end

@interface MTTableViewIndexViewLabel : UILabel

@property (nonatomic, assign) BOOL selected;

@end

@interface MTTableViewIndexViewIndicator : UIView


@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIImageView *imgView;

@end
