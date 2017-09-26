//
//  MTPictureEmojiView.h
//  MTRealEstate
//
//  Created by HaoSun on 2017/8/3.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTPictureEmojiViewDelegate <NSObject>

- (void)picEmojiDidselectIndex:(NSInteger)index;

@end

@interface MTPictureEmojiView : UIView

/**
 所有需要加载的图片 +  加载 几张图片就是加载几个按钮
 */
@property (nonatomic, strong) NSArray <NSString *> *images;

@property (nonatomic, assign) NSInteger maxWordCount;

@property (nonatomic, assign) NSInteger updataWord;

@property (nonatomic, weak) id <MTPictureEmojiViewDelegate>delegate;

@end
