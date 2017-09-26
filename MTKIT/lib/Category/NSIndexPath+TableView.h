//
//  NSIndexPath+TableView.h
//  MTRealEstate
//
//  Created by 鲁志刚 on 2016/11/16.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (TableView)

+ (NSMutableArray <NSIndexPath *>*)indexPathsRowFrom:(NSInteger)from to:(NSInteger)to;

- (BOOL)isSameIndexPath:(NSIndexPath *)inp;

@end
