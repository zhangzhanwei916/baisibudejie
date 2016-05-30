//
//  AppDelegate.m
//  BuDeJie
//
//  Created by 张战威 on 16/3/31.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "AppDelegate.h"
#import "XMGTabBarController.h"
#import "XMGADViewController.h"
#import <AFNetworking.h>

@interface AppDelegate () <UITabBarControllerDelegate>
@property (nonatomic, strong) UIWindow *topWindow;
@end

@implementation AppDelegate
// 如何判断UITabBarController里面有多少个子控制器,看下tabBar中有多少个按钮

/**
 *  可以在这个AppDelegate方法中监听到状态栏的点击
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject locationInView:nil].y > 20) return;
    
    XMGLog(@"点击了状态栏")
}

#pragma mark - <UITabBarControllerDelegate>
/*
- (BOOL)xxx:(id)xxx shouldXXX : 用来控制允不允许执行某些行为
- (void)xxx:(id)xxx willXXX
- (void)xxx:(id)xxx didXXXX

 1.首先会调用shouldXXX
 2.shouldXXX返回NO，那么就不会调用willXXX和didXXXX方法
 3.shouldXXX返回YES，那么就会按顺序调用willXXX、didXXXX方法
 4.如果没有实现shouldXXX，那么就会按顺序调用willXXX、didXXXX方法
*/
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    XMGFunc
//}

#pragma mark - <UIApplicationDelegate>
// 程序启动的时候调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 进入广告界面
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 2.创建窗口的根控制器 => 一开始想显示什么效果
    self.window.rootViewController = [[XMGTabBarController alloc] init];
    // 创建广告界面:展示启动界面
//    XMGADViewController *adVc = [[XMGADViewController alloc] init];
//    self.window.rootViewController = adVc;
    
//    XMGTabBarController *tabBarVc = [[XMGTabBarController alloc] init];
//    tabBarVc.delegate = self;
//    self.window.rootViewController = tabBarVc;
    
    // 3.显示窗口 makeKey:UIApplication主窗口
    // 窗口会把根控制器的view添加到窗口
    [self.window makeKeyAndVisible];
    
    // 4.监控网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return YES;
}

//- (void)click
//{
//    XMGFunc
//}

// Application windows are expected to have a root view controller at the end of application launch

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
