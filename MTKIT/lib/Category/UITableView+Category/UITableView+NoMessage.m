//
//  UITableView+NoMessage.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/4/4.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "UITableView+NoMessage.h"
#import "UIImage+MTExtension.h"
#import "MTMacro.h"
#import <objc/runtime.h>
#import <Masonry.h>

@implementation UITableView (NoMessage)

- (UILabel *)mt_tableViewNoMSGTipLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.textColor = HEXCOLOR(0x737373);
    label.font = MTFONT14;
    label.text = @"没有查到你所需要的数据!";
    label.textAlignment = NSTextAlignmentCenter;
    label.hidden = true;
    return label;
}

- (void)showTipLable:(BOOL)flag
{
    self.mt_tipLabel.hidden = !flag;
}

- (void)setMt_tipLabel:(UILabel *)label
{
    objc_setAssociatedObject(self, MTTableViewTipLableKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

const void * MTTableViewTipLableKey = &MTTableViewTipLableKey;

- (UILabel *)mt_tipLabel
{
    UILabel *label = objc_getAssociatedObject(self, MTTableViewTipLableKey);
    if (label == nil) {
        label = [self mt_tableViewNoMSGTipLabel];
        [self addSubview:label];
        [self setMt_tipLabel:label];
        label.hidden = true;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0.0f);
        }];
    }
    return label;
}

@end
