//
//  LJHPhotoView.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/15.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHPhotoView.h"
#import "LJHPhoto.h"
@interface LJHPhotoView ()
@property (nonatomic, weak) UIImageView *gifView;
@end
@implementation LJHPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加一个GIF小图片
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(LJHPhoto *)photo
{
    _photo = photo;
    
    // 控制gifView的可见性
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    
    // 下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}

@end
