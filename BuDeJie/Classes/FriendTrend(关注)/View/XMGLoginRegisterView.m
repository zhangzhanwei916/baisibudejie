//
//  XMGLoginRegisterView.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/5.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGLoginRegisterView.h"

@interface XMGLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end

@implementation XMGLoginRegisterView
+ (instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"XMGLoginRegisterView" owner:nil options:nil] lastObject];
}

+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"XMGLoginRegisterView" owner:nil options:nil] firstObject];
}

// 从xib加载就会调用,就会把xib所有的属性全部设置
- (void)awakeFromNib
{
    UIImage *image = self.loginRegisterBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.loginRegisterBtn setBackgroundImage:image forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
