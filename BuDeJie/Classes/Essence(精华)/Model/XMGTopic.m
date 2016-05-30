//
//  XMGTopic.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/12.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGTopic.h"

@implementation XMGTopic

/*
 以后在使用除法时，可能会出现NaN错误
 NaN的全称是not a number, 如果0作为除数时就会出现NaN错误(比如10 / 0)
 */

- (CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    // 文字的Y值
    _cellHeight += 55;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(XMGScreenW - 2 * XMGMargin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + XMGMargin;
    
    // 中间内容的高度
    if (self.type != XMGTopicTypeWord) { // 非段子，可能是图片、声音、视频帖子
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        if (middleH >= XMGScreenH) { // 超过一个屏幕，就算是超长图片
            middleH = XMGScreenH * 0.3;
            self.bigPicture = YES;
        }
        CGFloat middleX = XMGMargin;
        CGFloat middleY = _cellHeight;
        self.middleF = CGRectMake(middleX, middleY, middleW, middleH);
        
        _cellHeight += middleH + XMGMargin;
    }
    
    // 最热评论的高度
    if (self.top_cmt.count) {
        _cellHeight += 21;
        
        NSString *username = self.top_cmt.firstObject[@"user"][@"username"];
        NSString *content = self.top_cmt.firstObject[@"content"];
        if (content.length == 0) { // 没有文字内容，是个语音评论
            content = @"[语音评论]";
        }
        NSString *topCmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
        _cellHeight += [topCmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + XMGMargin;
    }
    
    // 工具条的高度
    _cellHeight += 35 + XMGMargin;
    
    return _cellHeight;
}

@end
