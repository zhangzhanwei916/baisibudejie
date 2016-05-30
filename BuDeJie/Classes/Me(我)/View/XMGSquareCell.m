//
//  XMGSquareCell.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/6.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGSquareCell.h"
#import <UIImageView+WebCache.h>
#import "XMGSquareItem.h"

@interface XMGSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation XMGSquareCell

- (void)setItem:(XMGSquareItem *)item
{
    _item = item;
    
    // 给子控件赋值
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameView.text = item.name;
    
}
@end
