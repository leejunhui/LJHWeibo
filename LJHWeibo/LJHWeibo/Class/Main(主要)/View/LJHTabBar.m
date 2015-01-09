//
//  LJHTabBar.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHTabBar.h"
#import "LJHTabBarButton.h"
@interface LJHTabBar()
@property (strong, nonatomic) LJHTabBarButton *selectedButton;
@end
@implementation LJHTabBar


- (void)addTabBarItem:(UITabBarItem *)item
{
    LJHTabBarButton *button = [[LJHTabBarButton alloc] init];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    button.item = item;
    [self addSubview:button];
    
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}

- (void)buttonClick:(LJHTabBarButton *)button{

    if (self.delegate && [self.delegate respondsToSelector:@selector(LJHTabBar:DidSelectTabBarButtonFrom:to:)]) {
        [self.delegate LJHTabBar:self DidSelectTabBarButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    self.selectedButton.selected = YES;
}


/**
 *  设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i < self.subviews.count; i ++)
    {
        CGFloat buttonX = i * buttonW;
        UIButton *button = self.subviews[i];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = i;
    }
}
@end
