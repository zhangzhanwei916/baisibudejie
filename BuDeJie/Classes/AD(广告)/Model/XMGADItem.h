//
//  XMGADItem.h
//  BuDeJie
//
//  Created by 张战威 on 16/4/5.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import <Foundation/Foundation.h>
// w_picurl,ori_curl:广告界面跳转地址,w,h
@interface XMGADItem : NSObject

/** 广告图片*/
@property (nonatomic ,strong) NSString *w_picurl;
/** 广告界面跳转地址*/
@property (nonatomic ,strong) NSString *ori_curl;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

@end
