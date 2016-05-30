//
//  UIView+Frame.h
//  BuDeJie
//
//  Copyright © 2016年 张战威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property CGFloat xmg_width;
@property CGFloat xmg_height;
@property CGFloat xmg_x;
@property CGFloat xmg_y;
@property CGFloat xmg_centerY;
@property CGFloat xmg_centerX;

+ (instancetype)xmg_viewFromXib;
@end
