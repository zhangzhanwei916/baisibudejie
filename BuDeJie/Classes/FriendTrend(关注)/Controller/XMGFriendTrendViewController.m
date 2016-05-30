//
//  XMGFriendTrendViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/3/31.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGFriendTrendViewController.h"
#import "XMGLoginRegisterViewController.h"
#import "UITextField+Placeholder.h"

@interface XMGFriendTrendViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation XMGFriendTrendViewController
/*
    UITabBarItem:决定tabBar上按钮的内容
    UINavigationItem:决定导航条上内容,左边,右边,中间有内容
    UIBarButtonItem:决定导航条上按钮具体内容
 */

// 进入到登录注册界面
- (IBAction)loginRegister {
    // 登录注册控制器
    XMGLoginRegisterViewController *loginVc = [[XMGLoginRegisterViewController alloc] init];
    // modal
    [self presentViewController:loginVc animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置占位文字颜色
    _textField.placeholderColor = [UIColor yellowColor];
    
    // 设置占位文字
    // placeholder:设置占位文字,设置文字颜色
    _textField.placeholder = @"123123";

    [self setupNavBar];
}

// 设置导航条内容
- (void)setupNavBar
{
    // 左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 中间 titleView
    self.navigationItem.title = @"我的关注";
}
// 朋友推荐
- (void)friendsRecomment
{
    
}
@end
