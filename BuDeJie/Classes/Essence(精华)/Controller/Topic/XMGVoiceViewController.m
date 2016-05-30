//
//  XMGVoiceViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/9.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGVoiceViewController.h"

@implementation XMGVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[UISwitch alloc] init];
}

- (XMGTopicType)type
{
    return XMGTopicTypeVoice;
}

@end
