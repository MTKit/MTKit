//
//  UITextView+MTProperty.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/5/3.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "UITextView+MTProperty.h"

@implementation UITextView (MTProperty)
static const char * const MT_TEXTVIEW_SELECTED_RANGE_KEY = "MT_TEXTVIEW_SELECTED_RANGE_KEY";

- (void)setMt_selectedRange:(NSRange)mt_selectedRange
{
    if (NSEqualRanges(mt_selectedRange, self.mt_selectedRange) == false) {
        [self willChangeValueForKey:@"mt_selectedRange"];
        objc_setAssociatedObject(self, &MT_TEXTVIEW_SELECTED_RANGE_KEY, NSStringFromRange(mt_selectedRange), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"mt_selectedRange"];
    }
}

- (NSRange)mt_selectedRange
{
    id obj = objc_getAssociatedObject(self, &MT_TEXTVIEW_SELECTED_RANGE_KEY);
    if (obj) {
        if (MTClassMatch(obj, NSString)) {
            return NSRangeFromString(obj);
        }
    }
    return NSMakeRange(0, 0);
}

@end
