//
//  UITableView+Category.m
//  powerlife
//
//  Created by 陈行 on 16/6/3.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "UITableView+Category.h"

@implementation UITableView (Category)

- (id)tableViewCellByNibWithIdentifier:(NSString *)identifier{
    UITableViewCell * cell = [self dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        UINib * nib=[UINib nibWithNibName:identifier bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:identifier];
        cell=[self dequeueReusableCellWithIdentifier:identifier];
    }
    return cell;
}

- (id)tableViewCellByClassWithIdentifier:(NSString *)identifier{
    UITableViewCell * cell = [self dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        [self registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
        cell=[self dequeueReusableCellWithIdentifier:identifier];
    }
    return cell;
}

- (id)tableViewHeaderViewByNibWithIdentifier:(NSString *)identifier{
    UITableViewHeaderFooterView * headerView = [self dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if(headerView==nil){
        UINib * nib=[UINib nibWithNibName:identifier bundle:nil];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
        headerView=[self dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    }
    headerView.contentView.backgroundColor=[UIColor colorWithWhite:0.961 alpha:1.000];
    return headerView;
}

@end
