//
//  XMGTopic.h
//  BuDeJie
//
//  Created by 张战威 on 16/4/12.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XMGTopicType) {
    /** 全部 */
    XMGTopicTypeAll = 1,
    /** 图片 */
    XMGTopicTypePicture = 10,
    /** 文字 */
    XMGTopicTypeWord = 29,
    /** 声音 */
    XMGTopicTypeVoice = 31,
    /** 视频 */
    XMGTopicTypeVideo = 41
};

@interface XMGTopic : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 帖子的类型 */
@property (nonatomic, assign) NSInteger type;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 大图 */
@property (nonatomic, copy) NSString *image1;
/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;
/** 是否为超长图 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 播放数量 */
@property (nonatomic, assign) NSInteger playcount;
/** 声音文件的长度 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频文件的长度 */
@property (nonatomic, assign) NSInteger videotime;

/* 额外增加的属性（为了方便开发） */
/** 根据当前模型数据计算出来的cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect middleF;
@end
