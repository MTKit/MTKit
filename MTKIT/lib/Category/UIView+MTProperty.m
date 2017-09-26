//
//  UIView+MTProperty.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/4/26.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "UIView+MTProperty.h"
#import "UIButton+MTSwizzle.h"
#import "UIImageView+MTSwizzle.h"

@implementation UIView (MTProperty)
static const char * const MT_BUTTON_NUMBER_KEY = "MT_BUTTON_NUMBER_KEY";
static const char * const MT_PAGE_CODE_KEY = "MT_PAGE_CODE_KEY";
static const char * const MT_ORIGIN_IMG_KEY = "MT_ORIGIN_IMG_KEY";
static const char * const MT_PERMISSION_DENIED_KEY = "MT_PERMISSION_DENIED_KEY";
static const char * const MT_MAX_INPUT_LENGTH_KEY = "MT_MAX_INPUT_LENGTH_KEY";

#pragma mark mt_btnNum
- (NSString *)mt_btnNum
{
    return objc_getAssociatedObject(self, &MT_BUTTON_NUMBER_KEY);
}

- (void)setMt_btnNum:(NSString *)mt_btnNum
{
    if (self.mt_btnNum != mt_btnNum) {
        // 存储新的
        [self willChangeValueForKey:@"mt_btnNum"]; // KVO
        objc_setAssociatedObject(self, &MT_BUTTON_NUMBER_KEY,
                                 mt_btnNum, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self didChangeValueForKey:@"mt_btnNum"]; // KVO
    }
}
#pragma mark mt_pageCode
- (NSString *)mt_pageCode
{
    return objc_getAssociatedObject(self, &MT_PAGE_CODE_KEY);
}

- (void)setMt_pageCode:(NSString *)mt_pageCode
{
    if (self.mt_pageCode != mt_pageCode) {
        // 存储新的
        [self willChangeValueForKey:@"mt_pageCode"]; // KVO
        objc_setAssociatedObject(self, &MT_PAGE_CODE_KEY,
                                 mt_pageCode, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self didChangeValueForKey:@"mt_pageCode"]; // KVO
    }
}
#pragma mark mt_originImg
- (NSString *)mt_originImg
{
    return objc_getAssociatedObject(self, &MT_ORIGIN_IMG_KEY);
}

- (void)setMt_originImg:(UIImage *)mt_originImg
{
    if (self.mt_originImg != mt_originImg) {
        // 存储新的
        [self willChangeValueForKey:@"mt_originImg"]; // KVO
        objc_setAssociatedObject(self, &MT_ORIGIN_IMG_KEY,
                                 mt_originImg, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"mt_originImg"]; // KVO
    }
}
#pragma mark mt_permissionDenied
- (BOOL)mt_permissionDenied
{
    return [objc_getAssociatedObject(self, &MT_PERMISSION_DENIED_KEY) boolValue];
}

- (void)setMt_permissionDenied:(BOOL)mt_permissionDenied
{
    if (self.mt_permissionDenied != mt_permissionDenied) {
        // 存储新的
        [self willChangeValueForKey:@"mt_permissionDenied"]; // KVO
        objc_setAssociatedObject(self, &MT_PERMISSION_DENIED_KEY,
                                 @(mt_permissionDenied), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"mt_permissionDenied"]; // KVO
    }
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (id)self;
        if (mt_permissionDenied) {
            [btn mt_setButtonPermissionDenied];
        }else{
            [btn mt_setButtonPermissionAllow];
        }
    }else if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *img = (id)self;
        [img setImageViewPermissionDenied:mt_permissionDenied];
    }
}
#pragma mark mt_maxInputLength
- (int)mt_maxInputLength
{
    return [objc_getAssociatedObject(self, &MT_MAX_INPUT_LENGTH_KEY) intValue];
}

- (void)setMt_maxInputLength:(int)mt_maxInputLength
{
    if (self.mt_maxInputLength != mt_maxInputLength) {
        // 存储新的
        [self willChangeValueForKey:@"mt_maxInputLength"]; // KVO
        objc_setAssociatedObject(self, &MT_MAX_INPUT_LENGTH_KEY,
                                 @(mt_maxInputLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"mt_maxInputLength"]; // KVO
    }
}

@end
