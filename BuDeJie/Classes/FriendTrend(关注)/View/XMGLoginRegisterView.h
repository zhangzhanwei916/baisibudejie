//
//  XMGLoginRegisterView.h
//  BuDeJie
//
//  Created by 张战威 on 16/4/5.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGLoginRegisterView : UIView

@property (nonatomic, assign) BOOL isLogin;
+ (instancetype)loginView;
+ (instancetype)registerView;

@end
