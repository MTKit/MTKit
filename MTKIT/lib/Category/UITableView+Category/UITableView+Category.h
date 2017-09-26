//
//  UITableView+Category.h
//  powerlife
//
//  Created by 陈行 on 16/6/3.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Category)

- (id)tableViewCellByNibWithIdentifier:(NSString *)identifier;

- (id)tableViewCellByClassWithIdentifier:(NSString *)identifier;

- (id)tableViewHeaderViewByNibWithIdentifier:(NSString *)identifier;

@end
