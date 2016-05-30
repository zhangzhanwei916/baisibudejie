//
//  XMGTopicPictureView.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/15.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import "XMGTopic.h"
#import "XMGSeeBigPictureViewController.h"

@interface XMGTopicPictureView()
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation XMGTopicPictureView

// XMGTopicVideoView.height == UITableViewCellContentView.height - 372.665
// XMGTopicPictureView.height == UITableViewCellContentView.height - 171.832

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

/**
 *  查看大图
 */
- (void)seeBigPicture
{
    XMGSeeBigPictureViewController *vc = [[XMGSeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    
    // 中间的图片
    [self.imageView xmg_setImageWithOriginalImageURL:topic.image1 thumbnailImageURL:topic.image0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return; // 下载失败
        if (!topic.isBigPicture) return; // 不是长图
        
        // 开启图形上下文
        CGFloat imageW = topic.middleF.size.width;
        CGFloat imageH = topic.middleF.size.height;
        UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
        
        // 绘图
        [image drawInRect:CGRectMake(0, 0, imageW, imageW * topic.height / topic.width)];
        
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 关闭图形上下文
        UIGraphicsEndImageContext();
    }];
    
    // gif标识
    self.gifView.hidden = !topic.is_gif;
    
    // 查看大图
    self.seeBigPictureButton.hidden = !topic.isBigPicture;
}

@end
