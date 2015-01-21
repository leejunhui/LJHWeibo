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
    attrs[NSFontAttributeName]            = iOS7 ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:12];
    NSShadow *shadow                      = [[NSShadow alloc] init];
    shadow.shadowOffset                   = CGSizeZero;
    attrs[NSShadowAttributeName]          = shadow;
    [barButton setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [barButton setTitleTextAttributes:attrs forState:UIControlStateHighlighted];

    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
    disabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [barButton setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];
}

+ (void)setupNavTheme{
    UINavigationBar *bar = [UINavigationBar appearance];
//    bar.tintColor = LJHColor(40, 40, 40);
    bar.tintColor = [UIColor whiteColor];
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
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back" highIcon:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_more" highIcon:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)more{
    [self popToRootViewControllerAnimated:YES];
}

@end

