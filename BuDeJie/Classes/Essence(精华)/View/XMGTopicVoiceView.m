//
//  XMGTopicVoiceView.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/15.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGTopicVoiceView.h"
#import "XMGTopic.h"
#import "XMGSeeBigPictureViewController.h"

@interface XMGTopicVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation XMGTopicVoiceView

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
    
    // 中间图片
    [self.imageView xmg_setImageWithOriginalImageURL:topic.image1 thumbnailImageURL:topic.image0];
    
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topic.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    // %02zd : 占据2位，多余的空位用0来填补
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
}
@end
