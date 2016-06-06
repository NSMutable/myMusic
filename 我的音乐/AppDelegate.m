//
//  AppDelegate.m
//  我的音乐
//
//  Created by 陈淼 on 16/6/6.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabBarController.h"
#import <AVOSCloud/AVOSCloud.h>

#define AVOSCloudAppID  @"G3ROSsF7zRSA3vHD5zw7mDv1"
#define AVOSCloudAppKey @"xx0gLOhJsksq4DauasmJrTGf"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    
    NSArray *tabArray = [NSArray arrayWithObject:baseNav];
    
    BaseTabBarController *tab = [[BaseTabBarController alloc] init];
    tab.viewControllers = tabArray;
    self.window.rootViewController = tab;
    
    
    //设置AVOSCloud
    [AVOSCloud setApplicationId:AVOSCloudAppID
                      clientKey:AVOSCloudAppKey];
    
    //统计应用启动情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
#if !TARGET_IPHONE_SIMULATOR
    [AVOSCloud registerForRemoteNotification];
#endif
    
    // 输出内部日志，发布时记得关闭
#ifdef DEBUG
    [AVOSCloud setAllLogsEnabled:YES];
#endif
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
