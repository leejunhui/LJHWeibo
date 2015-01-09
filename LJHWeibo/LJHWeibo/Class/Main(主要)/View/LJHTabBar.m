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
@property (strong, nonatomic) NSMutableArray *tabBarButtons;
@property (weak,   nonatomic) UIButton *plusButton;
@end
@implementation LJHTabBar

- (NSMutableArray *)tabBarButtons{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizedImageWithName:@"tabbar_background"]];
        }
        
        
        /**
         *  初始化中间的加号按钮
         */
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.frame = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height + 10);
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    return self;
}


- (void)addTabBarItem:(UITabBarItem *)item
{
    LJHTabBarButton *button = [[LJHTabBarButton alloc] init];
    [self.tabBarButtons addObject:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    button.item = item;
    [self addSubview:button];
    
    if (self.tabBarButtons.count == 1) {
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
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.plusButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    CGFloat buttonY = 0;
    CGFloat buttonW = width / self.subviews.count;
    CGFloat buttonH = height;
    for (int i = 0; i < self.tabBarButtons.count; i ++)
    {
        CGFloat buttonX = i * buttonW;
        UIButton *button = self.tabBarButtons[i];
        if(i > 1)
        {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = i;
    }
}
@end
