//
//  XMGNewViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/3/31.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGNewViewController.h"
#import "XMGSubTagViewController.h"

@interface XMGNewViewController ()

@end

@implementation XMGNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    
    [self setupNavBar];
}

// 设置导航条内容
- (void)setupNavBar
{
    // 左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subTag)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    // 中间 titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

// 点击了订阅标签
- (void)subTag
{
    // 创建订阅标签控制器
    XMGSubTagViewController *subTagVc = [[XMGSubTagViewController alloc] init];

    
    // 跳转到订阅标签控制器
    [self.navigationController pushViewController:subTagVc animated:YES];
    
}

@end
