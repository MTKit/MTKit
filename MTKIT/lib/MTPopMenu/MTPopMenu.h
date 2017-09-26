//
//  MTPopMenu.h
//  PopMenu
//
//  Created by 鲁志刚 on 2017/3/16.
//  Copyright © 2017年 FEBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTPopMenu : UIView

- (instancetype)initWithTitles:(NSArray <NSString *> *)titles images:(NSArray <NSString *> *)images NS_DESIGNATED_INITIALIZER;
/**
 *  显示POP MENU, 实现Block的时候注意循环引用
 *
 *  @param sender        需要显示在哪个按钮的正下方
 *  @param view          父View
 *  @param selectedIndex 选择之后的回调
 */
- (void)popViewForSender:(UIView *)sender inView:(UIView *)view selectedIndex:(void (^)(NSUInteger index))selectedIndex;

- (void)dismissPopView;
/**  是否显示箭头, Default is false */
@property (nonatomic, assign) BOOL showArrow;
/** 背景色 */
- (void)setPopMenuBackgroundColor:(UIColor *)color;
/** 文字颜色 */
- (void)setPopMenuTitleColor:(UIColor *)color;
/** 选中或者高亮时候的背景色 */
- (void)setSelectedBackgroudColor:(UIColor *)color;

@end

@interface MTPopMenuCell : UITableViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *img;

@end

@interface CAShapeLayerWithStartPoint : CAShapeLayer

@property (nonatomic,assign) CGPoint startPoint;

@end

