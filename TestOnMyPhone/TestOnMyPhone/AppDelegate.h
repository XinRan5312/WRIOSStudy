//
//  AppDelegate.h
//  TestOnMyPhone
//
//  Created by 新然 on 2017/6/9.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

