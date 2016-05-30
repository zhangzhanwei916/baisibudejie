//
//  XMGRefreshHeader.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/22.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGRefreshHeader.h"

@implementation XMGRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 自动切换透明度
        self.automaticallyChangeAlpha = YES;
        // 隐藏
        self.lastUpdatedTimeLabel.hidden = YES;
        // 调整文字颜色
        self.stateLabel.font = [UIFont systemFontOfSize:16];
        self.stateLabel.textColor = [UIColor blueColor];
        [self setTitle:@"🐴上往下拉吧" forState:MJRefreshStateIdle];
        [self setTitle:@"松开🐴上刷新" forState:MJRefreshStatePulling];
        [self setTitle:@"正在拼命刷新..." forState:MJRefreshStateRefreshing];
    }
    return self;
}

@end
