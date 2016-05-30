//
//  XMGTopicCell.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/13.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>

#import "XMGTopicPictureView.h"
#import "XMGTopicVideoView.h"
#import "XMGTopicVoiceView.h"

@interface XMGTopicCell()
// 控件的命名 = 功能作用 + 控件类型
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;
/* 中间控件 */
/** 图片控件 */
@property (nonatomic, weak) XMGTopicPictureView *pictureView;
/** 声音控件 */
@property (nonatomic, weak) XMGTopicVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic, weak) XMGTopicVideoView *videoView;
@end

@implementation XMGTopicCell
#pragma mark - 懒加载
- (XMGTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView xmg_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XMGTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        XMGTopicVoiceView *voiceView = [XMGTopicVoiceView xmg_viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (XMGTopicVideoView *)videoView
{
    if (!_videoView) {
        XMGTopicVideoView *videoView = [XMGTopicVideoView xmg_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

#pragma mark - 出事变化
- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    // 最热评论
    if (topic.top_cmt.count) { // 有最热评论
        self.topCmtView.hidden = NO;
        
        NSString *username = topic.top_cmt.firstObject[@"user"][@"username"];
        NSString *content = topic.top_cmt.firstObject[@"content"];
        if (content.length == 0) { // 没有文字内容，是个语音评论
            content = @"[语音评论]";
        }
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
    // 添加中间的内容
    switch (topic.type) {
        case XMGTopicTypePicture: { // 图片
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            self.pictureView.hidden = NO;
            self.pictureView.topic = topic;
            break;
        }
            
        case XMGTopicTypeVoice: { // 声音
            self.voiceView.hidden = NO;
            self.voiceView.topic = topic;
            self.videoView.hidden = YES;
            self.pictureView.hidden = YES;
            break;
        }
            
        case XMGTopicTypeVideo: { // 视频
            self.voiceView.hidden = YES;
            self.videoView.hidden = NO;
            self.videoView.topic = topic;
            self.pictureView.hidden = YES;
            break;
        }
            
        case XMGTopicTypeWord: { // 段子
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            self.pictureView.hidden = YES;
            break;
        }
            
        default: break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (self.topic.type) {
        case XMGTopicTypePicture: { // 图片
            self.pictureView.frame = self.topic.middleF;
            break;
        }
            
        case XMGTopicTypeVoice: { // 声音
            self.voiceView.frame = self.topic.middleF;
            break;
        }
            
        case XMGTopicTypeVideo: { // 视频
            self.videoView.frame = self.topic.middleF;
            break;
        }
            
        default: break;
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= XMGMargin;
    [super setFrame:frame];
}

- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}
@end
