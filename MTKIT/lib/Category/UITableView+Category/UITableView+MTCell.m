//
//  UITableViewCell+MTCell.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 16/7/26.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "UITableView+MTCell.h"


@implementation UITableView (MTCell)

- (NSIndexPath *)indexPathForView:(UIView *)view
{
    UIView *target = view;
    while (target.superview) {
        if ([target isKindOfClass:[UITableViewCell class]]) {
            break;
        }
        target = target.superview;
    }
    if ([target isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)target;
        if (cell) {
            return [self indexPathForCell:cell];
        }
    }
    return nil;
}

static const NSString *kSHOW_INDEX_VIEW_KEY = @"mt_showIndexView";

- (void)mt_showIndexView {
    if (self.superview) {
        if (self.mt_indexView.superview == nil) {
            [self.superview addSubview:self.mt_indexView];
            [self.mt_indexView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(20.f);
                make.top.bottom.right.mas_equalTo(0.0f);
            }];
        }
    }
}

- (MTTableViewIndexView *)mt_indexView {
    MTTableViewIndexView *view = objc_getAssociatedObject(self, &kSHOW_INDEX_VIEW_KEY);
    if (view == nil) {
        view = [[MTTableViewIndexView alloc] initWithFrame:CGRectZero];
        view.tableView = self;
        objc_setAssociatedObject(self, &kSHOW_INDEX_VIEW_KEY, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

@end
