//
//  XMGTopicCell.h
//  BuDeJie
//
//  Created by 张战威 on 16/4/13.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGTopic;

@interface XMGTopicCell : UITableViewCell
/** 帖子模型数据 */
@property (nonatomic, strong) XMGTopic *topic;
@end
