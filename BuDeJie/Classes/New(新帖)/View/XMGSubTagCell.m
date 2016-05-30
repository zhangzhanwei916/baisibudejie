//
//  XMGSubTagCell.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/5.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGSubTagCell.h"
#import "XMGSubTagItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Antialias.h"
#import "UIImage+Render.h"

/*
 插件的安装路径：
 1./Users/用户名/Library/Application Support/Developer/Shared/Xcode/Plug-ins
 2./Users/用户名/Library/Developer/Xcode/Plug-ins
 */

@interface XMGSubTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;
@end

@implementation XMGSubTagCell

/*
    界面细节:
    1.头像 圆 1.修改控件的圆角半径 2.裁剪图片生成一张新的圆角图片,图形上下文
    2.数字
 */

/*
    iOS9,帧数不会下降,苹果修复这个问题
    iOS8之前 还是有问题
 */
- (void)setItem:(XMGSubTagItem *)item
{
    _item = item;
    
    // 头像
    UIImage *placeholder = [UIImage xmg_circleImageNamed:@"defaultUserIcon"];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return ;
        
        self.iconView.image =  [image circleImage];
        
    }];
    
    // 姓名
    _nameView.text = item.theme_name;
    
    // 订阅数量
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",item.sub_number];
    
    // intValue:只转换数字字符串
    NSInteger num = numStr.intValue;
    
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    _numView.text = numStr;
}

// 从xib加载就会调用,只会调用一次
- (void)awakeFromNib {
//    self.iconView.layer.cornerRadius = self.iconView.xmg_width * 0.5;
//    // 超出主层边框就会被裁剪掉
//    self.iconView.layer.masksToBounds = YES;
//    // Initialization code
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    
    // 给cellframe赋值
    [super setFrame:frame];
}

@end
