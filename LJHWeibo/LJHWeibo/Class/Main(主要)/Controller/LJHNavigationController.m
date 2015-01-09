//
//  LJHNavigationController.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHNavigationController.h"

@implementation LJHNavigationController

+ (void)initialize{
    [self setupNavTheme];
    [self setupBarButton];
}

+ (void)setupBarButton{
    UIBarButtonItem *barButton = [UIBarButtonItem appearance];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = iOS7 ? [UIColor orangeColor] :[UIColor blackColor];
    attrs[NSFontAttributeName]            = iOS7 ? [UIFont systemFontOfSize:14] : [UIFont systemFontOfSize:12];
    NSShadow *shadow                      = [[NSShadow alloc] init];
    shadow.shadowOffset                   = CGSizeZero;
    attrs[NSShadowAttributeName]          = shadow;
    [barButton setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [barButton setTitleTextAttributes:attrs forState:UIControlStateHighlighted];
}

+ (void)setupNavTheme{
    UINavigationBar *bar = [UINavigationBar appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    attrs[NSFontAttributeName]            = [UIFont boldSystemFontOfSize:19];
    NSShadow *shadow                      = [[NSShadow alloc] init];
    shadow.shadowOffset                   = CGSizeZero;
    attrs[NSShadowAttributeName]          = shadow;
    [bar setTitleTextAttributes:attrs];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        self.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

@end

