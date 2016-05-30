//
//  XMGTopicViewController.h
//  BuDeJie
//
//  Created by 张战威 on 16/4/20.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGTopic.h"

@interface XMGTopicViewController : UITableViewController
/** 帖子的类型(交给子类去重写)*/
- (XMGTopicType)type;

//@property (nonatomic, assign, readonly) XMGTopicType type;
//@property (nonatomic, assign) XMGTopicType type;
@end


/*
 A : UITableViewController
 - [D run]
 - [D test]
 - a
 
 B : UICollectionViewController
 - [D run]
 - [D test]
 - b
 
 C : UIViewController
 - [D run]
 - [D test]
 - c
 
 D : NSObject
 - run
 - test
 */
