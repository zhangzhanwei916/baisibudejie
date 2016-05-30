//
//  XMGDIYHeader.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/22.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGDIYHeader.h"

@interface XMGDIYHeader()
@property (nonatomic, strong) UISwitch *s;
@end

@implementation XMGDIYHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.xmg_height = 80;
        
        UISwitch *s = [[UISwitch alloc] init];
        [self addSubview:s];
        self.s = s;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.s.center = CGPointMake(self.xmg_width * 0.5, self.xmg_height * 0.5);
}

/**
 *  监听刷新控件的状态
 */
- (void)setState:(MJRefreshState)state
{
    [super setState:state];
    
    switch (state) {
        case MJRefreshStateIdle: {// 普通
            [self.s setOn:NO animated:YES];
            
            [UIView animateWithDuration:0.25 animations:^{
                self.s.transform = CGAffineTransformIdentity;
            }];
            break;
        }
            
        case MJRefreshStateRefreshing:
        case MJRefreshStatePulling: {// 松开就可以刷新
            [self.s setOn:YES animated:YES];
            
            [UIView animateWithDuration:0.25 animations:^{
                self.s.transform = CGAffineTransformMakeRotation(M_PI_2);
            }];
            break;
        }
            
//        case MJRefreshStateRefreshing: { // 正在刷新
//            
//            break;
//        }
            
        default:
            break;
    }
}

@end
