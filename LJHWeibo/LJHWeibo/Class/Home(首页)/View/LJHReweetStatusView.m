//
//  LJHReweetStatusView.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/12.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  微博cell内部转发的内容

#import "LJHReweetStatusView.h"
#import "LJHStatusFrame.h"
#import "LJHStatus.h"
#import "LJHUser.h"
#import "LJHPhoto.h"
#import "LJHPhotosView.h"
@interface LJHReweetStatusView()
/** 被转发微博作者的昵称 */
@property (weak, nonatomic) UILabel *retweetNameLabel;
/** 被转发微博的正文 */
@property (weak, nonatomic) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (weak, nonatomic) LJHPhotosView *retweetPhotosView;
@end

@implementation LJHReweetStatusView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        //1.设置背景图片
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        /**2.被转发微博作者的昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = LJHRetweetStatusNameFont;
        [self addSubview:retweetNameLabel];
        retweetNameLabel.textColor = LJHColor(67, 107, 163);
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        self.retweetNameLabel = retweetNameLabel;
        
        /**3.被转发微博的正文 */
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = LJHRetweetStatusContentFont;
        retweetContentLabel.numberOfLines = 0;
        [self addSubview:retweetContentLabel];
        retweetContentLabel.textColor = LJHColor(90, 90, 90);
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        self.retweetContentLabel = retweetContentLabel;
        
        /**4.被转发微博的配图 */
        LJHPhotosView *retweetPhotoView = [[LJHPhotosView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotosView = retweetPhotoView;
        
    }
    return self;
}

- (void)setStatusFrame:(LJHStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    LJHStatus *retweeted_status = statusFrame.status.retweeted_status;
    LJHUser *user     = retweeted_status.user;
    //2.昵称
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    //3.正文
    self.retweetContentLabel.text = retweeted_status.text;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    //4.配图
    if (retweeted_status.pic_urls.count)
    {
        self.retweetPhotosView.hidden = NO;
        self.retweetPhotosView.frame = self.statusFrame.retweetPhotosViewF;
        self.retweetPhotosView.photos = retweeted_status.pic_urls;
    }
    else{
        self.retweetPhotosView.hidden = YES;
    }
}


@end
