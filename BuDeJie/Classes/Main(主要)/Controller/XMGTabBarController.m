//
//  XMGTabBarController.m
//  BuDeJie
//
//  Created by 张战威 on 16/3/31.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGEssenceViewController.h"
#import "XMGFriendTrendViewController.h"
#import "XMGMeViewController.h"
#import "XMGPublishViewController.h"
#import "XMGNewViewController.h"
#import "XMGTabBar.h"
#import "XMGNavigationController.h"

#import "UIImage+Render.h"

@interface XMGTabBarController ()

@end

@implementation XMGTabBarController

+ (void)load
{
    // 获取当前类的tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置所有item的选中时颜色
    // 设置选中文字颜色
    // 创建字典去描述文本
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    // 文本颜色 -> 描述富文本属性的key -> NSAttributedString.h
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];

    // 通过normal状态设置字体大小
    // 字体大小 跟 normal
    NSMutableDictionary *attrnor = [NSMutableDictionary dictionary];
   
    // 设置字体
    attrnor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    [item setTitleTextAttributes:attrnor forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加所有子控制器
    [self setupAllChildViewController];
    
    // 设置tabBar上对应按钮内容 -> 由对应的子控制器的tabBarItem 决定
    [self setupAllTileButton];
    
    // 自定义tabBar
    [self setupTabBar];
}

#pragma mark - 添加所有的子控制器
- (void)setupAllChildViewController
{
    // 精华
    XMGEssenceViewController *essenceVc = [[XMGEssenceViewController alloc] init];
    XMGNavigationController *nav = [[XMGNavigationController alloc] initWithRootViewController:essenceVc];
    [self addChildViewController:nav];
    
    // 新帖
    XMGNewViewController *newVc = [[XMGNewViewController alloc] init];
    XMGNavigationController *nav1 = [[XMGNavigationController alloc] initWithRootViewController:newVc];
    [self addChildViewController:nav1];
    
    // 关注
    XMGFriendTrendViewController *friendTrendVc = [[XMGFriendTrendViewController alloc] init];
    XMGNavigationController *nav3 = [[XMGNavigationController alloc] initWithRootViewController:friendTrendVc];
    [self addChildViewController:nav3];
    
    // 我
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"XMGMeViewController" bundle:nil];
    // 加载箭头指向控制器
    XMGMeViewController *meVc = [storyboard instantiateInitialViewController];
    XMGNavigationController *nav4 = [[XMGNavigationController alloc] initWithRootViewController:meVc];
    [self addChildViewController:nav4];
    
}

#pragma mark - tabbar的代理方法
//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{// 这里不需要调用super，因为父类没有实现这个代理方法
//    XMGFunc
//}

#pragma mark - 自定义tabBar
- (void)setupTabBar
{
    XMGTabBar *tabBar = [[XMGTabBar alloc] init];
    
    // 替换系统的tabBar KVC:设置readonly属性
    [self setValue:tabBar forKey:@"tabBar"];
}

/*
 Changing the delegate of 【a tab bar managed by a tab bar controller】 is not allowed.
 被UITabBarController所管理的UITabBar，它的delegate不允许被修改
 */

#pragma mark - 设置所有标题按钮内容
- (void)setupAllTileButton
{
    // 0:精华
    UINavigationController *nav = self.childViewControllers[0];
    // 标题
    nav.tabBarItem.title = @"精华";
    // 图片
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    
    // 选中
    nav.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_essence_click_icon"];
    
    // 1:新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    // 标题
    nav1.tabBarItem.title = @"新帖";
    // 图片
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    // 选中
    nav1.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_new_click_icon"];

    // 3:关注
    UINavigationController *nav3 = self.childViewControllers[2];
    // 标题
    nav3.tabBarItem.title = @"关注";
    // 图片
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    // 选中
    nav3.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_friendTrends_click_icon"];
    
    // 4:我
    UINavigationController *nav4 = self.childViewControllers[3];
    // 标题
    nav4.tabBarItem.title = @"我";
    // 图片
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    // 选中
    nav4.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_me_click_icon"];
    
}

@end
