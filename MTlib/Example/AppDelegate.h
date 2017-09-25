//
//  AppDelegate.h
//  MTlib
//
//  Created by HaoSun on 2017/9/25.
//  Copyright © 2017年 MTKIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

