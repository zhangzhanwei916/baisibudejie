//
//  XMGFastLoginView.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/5.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGFastLoginView.h"

@implementation XMGFastLoginView
+ (instancetype)fastLoginView
{
      return [[[NSBundle mainBundle] loadNibNamed:@"XMGFastLoginView" owner:nil options:nil] firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
