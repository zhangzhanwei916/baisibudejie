//
//  XMGFastLoginButton.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/5.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGFastLoginButton.h"

@implementation XMGFastLoginButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    self.imageView.xmg_y = 0;
    
    // 根据文字内容计算下label,设置好label尺寸
    [self.titleLabel sizeToFit];
    self.titleLabel.xmg_centerX = self.xmg_width * 0.5;
    self.titleLabel.xmg_y = self.xmg_height - self.titleLabel.xmg_height;
    
    // 文字显示不出来:label尺寸不够 -> label跟文字一样
    // label宽度 => 计算文字宽度
}
@end
