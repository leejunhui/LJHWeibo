//
//  LJHTabBarController.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHTabBarController.h"
#import "LJHHomeViewController.h"
#import "LJHMessageViewController.h"
#import "LJHDiscoverController.h"
#import "LJHMeViewController.h"
#import "LJHTabBar.h"

@interface LJHTabBarController()<LJHTabBarDelegate>
@property (weak, nonatomic) LJHTabBar *customTabBar;
@end


@implementation LJHTabBarController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /**
     *  去除系统的UITabBarButton
     */
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupCustomTabBar];
    [self setupAllChildControllers];
}

/**
 *  加载自定义TabBar
 */
- (void)setupCustomTabBar{
    LJHTabBar *customTabBar = [[LJHTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    self.customTabBar = customTabBar;
    [self.tabBar addSubview:customTabBar];
}

/**
 *  加载控制器
 */
- (void)setupAllChildControllers{
    LJHHomeViewController *home = [[LJHHomeViewController alloc] init];
    home.tabBarItem.badgeValue = @"99+";
    [self setupChildVC:home title:@"首页" icon:@"tabbar_home" highIcon:@"tabbar_home_selected"];

    LJHMessageViewController *message = [[LJHMessageViewController alloc] init];
    [self setupChildVC:message title:@"消息" icon:@"tabbar_message_center" highIcon:@"tabbar_message_center_selected"];
    
    LJHDiscoverController *discover = [[LJHDiscoverController alloc] init];
    [self setupChildVC:discover title:@"广场" icon:@"tabbar_discover" highIcon:@"tabbar_discover_selected"];
    
    LJHMeViewController *me = [[LJHMeViewController alloc] init];
     [self setupChildVC:me title:@"我" icon:@"tabbar_profile" highIcon:@"tabbar_profile_selected"];
}

/**
 *  快速创建一个子控制器
 *
 *  @param child     子控制器
 *  @param title     标题
 *  @param icon      图片
 *  @param hightIcon 选中时的图片
 */
- (void)setupChildVC:(UIViewController *)child title:(NSString *)title icon:(NSString *)icon highIcon:(NSString *)highIcon{
    child.title = title;
    child.tabBarItem.title = title;
    child.tabBarItem.image = [UIImage imageWithName:icon];
    UIImage *selectedImage = [UIImage imageWithName:highIcon];
    if (iOS7) {
        child.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else{
        child.tabBarItem.selectedImage = selectedImage;
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:child];
    [self addChildViewController:nav];
    /**
     *  将子控制器所拥有的那个tabBarItem取出来传给自定义的tabBar来管理
     */
    [self.customTabBar addTabBarItem:child.tabBarItem];
}

#pragma mark - LJHTabBarDelegate
- (void)LJHTabBar:(LJHTabBar *)tabBar DidSelectTabBarButtonFrom:(int)from to:(int)to{
    self.selectedIndex = to;
}

@end
