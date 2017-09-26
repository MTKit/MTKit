//
//  NSIndexPath+TableView.m
//  MTRealEstate
//
//  Created by 鲁志刚 on 2016/11/16.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "NSIndexPath+TableView.h"
#import <UIKit/UIKit.h>

@implementation NSIndexPath (TableView)

+ (NSMutableArray<NSIndexPath *> *)indexPathsRowFrom:(NSInteger)from to:(NSInteger)to
{
    NSMutableArray *mRet = [NSMutableArray array];
    for (NSInteger i = from; i < to; i++) {
        [mRet addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    return mRet;
}

- (BOOL)isSameIndexPath:(NSIndexPath *)inp {
    return (self.row == inp.row && self.section == inp.section);
}

@end
