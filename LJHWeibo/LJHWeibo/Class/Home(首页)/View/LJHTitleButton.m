//
//  LJHTitleButton.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  导航栏标题按钮

#import "LJHTitleButton.h"

@implementation LJHTitleButton
+(instancetype)titleButton{
    return [[LJHTitleButton alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - LJHTitleButtonImageW;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageY = 0;
    CGFloat imageW = LJHTitleButtonImageW;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    // 根据title计算自己的宽度
    CGFloat titleW = [LJHTextSizeTool sizeWithText:title font:self.titleLabel.font maxSize:LJHStatusMaxSize].width;
//    CGFloat titleW = [title sizeWithFont:self.titleLabel.font].width;
    CGRect frame = self.frame;
    frame.size.width = titleW + LJHTitleButtonImageW + 5;
    self.frame = frame;
    [super setTitle:title forState:state];
}

@end
