//
//  XMGLoginRegisterViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/5.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"
#import "XMGLoginRegisterView.h"
#import "XMGFastLoginView.h"
/*
    思想:
    自定义view:以后只要看到比较复杂界面 
    在开发中,如果碰见很多view都有同样的功能,自定义view去管理所有的view
 */
@interface XMGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation XMGLoginRegisterViewController

// 点击关闭
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击注册账号
- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    // 移动中间的view
    
    _leadCons.constant =  _leadCons.constant==0? -XMGScreenW : 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加登录view
    // 默认一个view从xib加载,尺寸跟xib一样
    XMGLoginRegisterView *loginView = [XMGLoginRegisterView loginView];
    [self.middleView addSubview:loginView];
    
    // 添加注册view
    XMGLoginRegisterView *registerView = [XMGLoginRegisterView registerView];
    [self.middleView addSubview:registerView];
    
    // 添加快速登录view
    XMGFastLoginView *fastView = [XMGFastLoginView fastLoginView];
    [self.bottomView addSubview:fastView];
    
}

// 执行约束,里面尺寸才是最准确.
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // 设置登录
    XMGLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height);

    // 设置注册
    XMGLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.xmg_width * 0.5, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height);
    
    // 设置快速登录view
    XMGFastLoginView *fastView = self.bottomView.subviews[0];
    fastView.frame = self.bottomView.bounds;
}

@end
