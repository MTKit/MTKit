//
//  UITextField+MTProperty.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2017/5/3.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "UITextField+MTProperty.h"
static const char * const MT_TEXTFIELD_SELECTED_TEXT_RANGE_KEY = "MT_TEXTFIELD_SELECTED_TEXT_RANGE_KEY";

@implementation UITextField (MTProperty)

- (void)setMt_selectedRange:(NSRange)mt_selectedRange
{
    if (NSEqualRanges(mt_selectedRange, self.mt_selectedRange) == false) {
        [self willChangeValueForKey:@"mt_selectedRange"];
        objc_setAssociatedObject(self, &MT_TEXTFIELD_SELECTED_TEXT_RANGE_KEY, NSStringFromRange(mt_selectedRange), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"mt_selectedRange"];
    }
}

- (NSRange)mt_selectedRange
{
    id obj = objc_getAssociatedObject(self, &MT_TEXTFIELD_SELECTED_TEXT_RANGE_KEY);
    if (obj) {
        if (MTClassMatch(obj, NSString)) {
            return NSRangeFromString(obj);
        }
    }
    return NSMakeRange(0, 0);
}

- (NSRange)mt_convertToSelectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

@end
