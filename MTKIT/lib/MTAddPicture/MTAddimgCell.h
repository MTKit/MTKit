//
//  MTAddimgCell.h
//  ALiEditPhotoCollection
//
//  Created by HaoSun on 2017/8/2.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTAddImgModel;
@protocol MTAddimgCellDelegate <NSObject>

- (void)delImageView:(MTAddImgModel *)model;
- (void)imageViewTap:(MTAddImgModel *)imageModel;
@end

@interface MTAddimgCell : UICollectionViewCell

@property (nonatomic, strong) MTAddImgModel *imageModel;

@property (nonatomic, weak) id <MTAddimgCellDelegate> delegate;
@end
