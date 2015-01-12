//
//  LJHStatusTopView.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/12.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  微博顶部的view

#import "LJHStatusTopView.h"
#import "LJHStatusFrame.h"
#import "LJHStatus.h"
#import "LJHUser.h"
#import "LJHReweetStatusView.h"
@interface LJHStatusTopView()
/** 头像 */
@property (weak, nonatomic) UIImageView *iconView;
/** 会员图标 */
@property (weak, nonatomic) UIImageView *vipView;
/** 配图 */
@property (weak, nonatomic) UIImageView *photoView;
/** 昵称 */
@property (weak, nonatomic) UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) UILabel *timeLabel;
/** 来源 */
@property (weak, nonatomic) UILabel *sourceLabel;
/** 正文 */
@property (weak, nonatomic) UILabel *contentLabel;
/** 被转发微博的view(父控件) */
@property (weak, nonatomic) LJHReweetStatusView *retweetView;
@end
@implementation LJHStatusTopView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //1.设置背景图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        
        /**2.头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /**3.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        vipView.contentMode = UIViewContentModeCenter;
        self.vipView = vipView;
        
        /**4.配图 */
        UIImageView *photoView = [[UIImageView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
        /**5.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        nameLabel.font = LJHStatusNameFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel = nameLabel;
        
        /**6.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        timeLabel.textColor = LJHColor(240, 140, 19);
        timeLabel.font = LJHStatusTimeFont;
        timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel = timeLabel;
        
        /**7.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        [self addSubview:sourceLabel];
        sourceLabel.textColor = LJHColor(135, 135, 135);
        sourceLabel.font = LJHStatusSourceFont;
        sourceLabel.backgroundColor = [UIColor clearColor];
        self.sourceLabel = sourceLabel;
        
        /**8.正文 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        sourceLabel.textColor = LJHColor(39, 39, 39);
        contentLabel.font = LJHStatusContentFont;
        contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel = contentLabel;
        
        /**1.被转发微博的view(父控件) */
        LJHReweetStatusView *retweetView = [[LJHReweetStatusView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}

- (void)setStatusFrame:(LJHStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    LJHStatus *status = statusFrame.status;
    LJHUser *user     = status.user;
    
    //2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    //3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    //4.会员
    if (user.mbtype) {
        self.vipView.hidden = NO;
        NSString *img = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageWithName:img];
        self.vipView.frame = self.statusFrame.vipViewF;
        self.nameLabel.textColor = LJHColor(241, 97, 28);
    }
    else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    
    //5.时间
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + LJHStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:LJHStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX,timeLabelY}, timeLabelSize};
    
    //6.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + LJHStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:LJHStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX,sourceLabelY}, sourceLabelSize};
    
    //7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    //8.配图
    if (status.thumbnail_pic)
    {
        self.photoView.hidden = NO;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        self.photoView.frame = self.statusFrame.photoViewF;
    }
    else{
        self.photoView.hidden = YES;
    }
    
    
    //9.转发的微博
    LJHStatus *retweeted_status = status.retweeted_status;
    if(retweeted_status){
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        //传递frame模型数据
        self.retweetView.statusFrame = self.statusFrame;
    }
    else {
        self.retweetView.hidden = YES;
    }
    
    
}
@end
