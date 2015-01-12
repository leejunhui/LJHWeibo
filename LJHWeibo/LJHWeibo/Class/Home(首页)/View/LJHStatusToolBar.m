//
//  LJHStatusToolBar.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHStatusToolBar.h"

@implementation LJHStatusToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        //1.设置背景图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted" left:0.9 top:0.5];
        
        //2.添加按钮
        [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        
        [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        
        [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
    }
    return self;
}

/**
 *  初始化按钮
 *
 *  @param title   按钮的文字
 *  @param image   按钮的小图标
 *  @param bgImage 按钮的背景
 */
- (void)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
}

/**
 *  对子控件进行布局
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (int index = 0; index < self.subviews.count; index ++) {
        UIButton *btn = self.subviews[index];
        
        //设置frame
        
        CGFloat btnY = 0;
        CGFloat btnW = self.frame.size.width / self.subviews.count;
        CGFloat btnH = self.frame.size.height;
        CGFloat btnX = index * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

@end
