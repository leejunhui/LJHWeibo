//
//  LJHStatusCell.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHStatusCell.h"
#import "LJHStatus.h"
#import "LJHUser.h"
#import "LJHStatusFrame.h"
#import "LJHStatusToolBar.h"
@interface LJHStatusCell()
/** 顶部的view */
@property (weak, nonatomic) UIImageView *topView;
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
@property (weak, nonatomic) UIImageView *retweetView;
/** 被转发微博作者的昵称 */
@property (weak, nonatomic) UILabel *retweetNameLabel;
/** 被转发微博的正文 */
@property (weak, nonatomic) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (weak, nonatomic) UIImageView *retweetPhotoView;

/** 微博的工具条 */
@property (weak, nonatomic) LJHStatusToolBar *statusToolBar;
@end

@implementation LJHStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"status";
    LJHStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LJHStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /**
         *  原创微博内部的子控件
         */
        [self setupOriginalStatusSubViews];
        /**
         *  转发微博内部的子控件
         */
        [self setupRetweetSubViews];
        /**
         *  微博的工具条
         */
        [self setupStatusToolBar];
    }
    return self;
}

/**
 *  原创微博内部的子控件
 */
- (void)setupOriginalStatusSubViews{
//    self.selectedBackgroundView = [[UIView alloc] init];
    
    /**1.顶部的view */
    UIImageView *topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
    topView.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    topView.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];

    self.topView = topView;
    
    /**2.头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /**3.会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    
    /**4.配图 */
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    /**5.昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.topView addSubview:nameLabel];
    nameLabel.font = LJHStatusNameFont;
    nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel = nameLabel;
    
    /**6.时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    [self.topView addSubview:timeLabel];
    timeLabel.textColor = LJHColor(240, 140, 19);
    timeLabel.font = LJHStatusTimeFont;
    timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel = timeLabel;
    
    /**7.来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [self.topView addSubview:sourceLabel];
    sourceLabel.textColor = LJHColor(135, 135, 135);
    sourceLabel.font = LJHStatusSourceFont;
    sourceLabel.backgroundColor = [UIColor clearColor];
    self.sourceLabel = sourceLabel;
    
    /**8.正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    [self.topView addSubview:contentLabel];
     sourceLabel.textColor = LJHColor(39, 39, 39);
    contentLabel.font = LJHStatusContentFont;
    contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel = contentLabel;
}

/**
 *  转发微博内部的子控件
 */
- (void)setupRetweetSubViews{
    /**1.被转发微博的view(父控件) */
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /**2.被转发微博作者的昵称 */
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = LJHRetweetStatusNameFont;
    [self.retweetView addSubview:retweetNameLabel];
    retweetNameLabel.textColor = LJHColor(67, 107, 163);
    retweetNameLabel.backgroundColor = [UIColor clearColor];
    self.retweetNameLabel = retweetNameLabel;
    
    /**3.被转发微博的正文 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = LJHRetweetStatusContentFont;
    retweetContentLabel.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentLabel];
    retweetContentLabel.textColor = LJHColor(90, 90, 90);
    retweetContentLabel.backgroundColor = [UIColor clearColor];
    self.retweetContentLabel = retweetContentLabel;
    
    /**4.被转发微博的配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 *  微博的工具条
 */
- (void)setupStatusToolBar{
    /** 微博的工具条 */
    LJHStatusToolBar *statusToolBar = [[LJHStatusToolBar alloc] init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
}


/**
 *  拦截frame的设置
 */

- (void)setFrame:(CGRect)frame{
    frame.origin.x = LJHStatusTableBorder;
    frame.origin.y += LJHStatusTableBorder;
    frame.size.height -= 2 * LJHStatusTableBorder;
    frame.size.width -= 2 * LJHStatusTableBorder;
    [super setFrame:frame];
}

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(LJHStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    /**
     *  原创微博
     */
    [self setupOriginalData];
    /**
     *  转发微博
     */
    [self setupRetweetData];
    /**
     *  微博的工具条
     */
    [self setupToolBar];
}

- (void)setupOriginalData{
    
    LJHStatus *status = self.statusFrame.status;
    LJHUser *user     = status.user;
                         
    //1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
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
}

- (void)setupRetweetData{
    LJHStatus *retweeted_status = self.statusFrame.status.retweeted_status;
    LJHUser *user     = retweeted_status.user;
    
    if(retweeted_status){
        self.retweetView.hidden = NO;
        //1.父控件
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        //2.昵称
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        //3.正文
        self.retweetContentLabel.text = retweeted_status.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        //4.配图
        if (retweeted_status.thumbnail_pic)
        {
            self.retweetPhotoView.hidden = NO;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweeted_status.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
        }
        else{
            self.retweetPhotoView.hidden = YES;
        }
    }
    else {
        self.retweetView.hidden = YES;
    }
    
}

- (void)setupToolBar{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    self.statusToolBar.status = self.statusFrame.status;
}

@end
