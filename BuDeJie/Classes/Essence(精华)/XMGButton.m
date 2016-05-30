//
//  XMGButton.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/20.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGButton.h"

@implementation XMGButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, 100, 20);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(100, 100, 20, 20);
}

@end


//@implementation UIButton
//
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(0, 0, 20, 20);
//}
//
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(100, 100, 10, 10);
//}
//
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    self.titleLabel.frame = [self titleRectForContentRect:self.bounds];
//    self.imageView.frame = [self imageRectForContentRect:self.bounds];
//}
//
//@end