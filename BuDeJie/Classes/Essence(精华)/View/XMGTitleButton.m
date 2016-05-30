//
//  XMGTitleButton.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/9.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGTitleButton.h"

@implementation XMGTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        // 文字颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

/**
 *  不让按钮达到高亮状态
 */
- (void)setHighlighted:(BOOL)highlighted {}
@end
