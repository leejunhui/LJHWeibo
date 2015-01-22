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
#import "LJHNavigationController.h"
#import "LJHComposeViewController.h"
#import "LJHUserUnreadCountParam.h"
#import "LJHUserUnreadCountResult.h"
#import "LJHUserTool.h"
#import "LJHAccount.h"
#import "LJHAccountTool.h"
@interface LJHTabBarController()<LJHTabBarDelegate>
@property (weak, nonatomic) LJHTabBar *customTabBar;
@property (weak, nonatomic) LJHHomeViewController *home;
@property (weak, nonatomic) LJHMessageViewController *message;
@property (weak, nonatomic) LJHDiscoverController *discover;
@property (weak, nonatomic) LJHMeViewController *me;
@property (assign, nonatomic) int unreadCountNumber;
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
    [self checkUnreadCount];
}

/**
 *  通过定时器来请求未读消息数
 */
- (void)checkUnreadCount{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(unreadCount) userInfo:nil repeats:YES];
    /**
     *  这句代码的作用是让定时器在子线程中执行，不会阻塞主线程
     */
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)unreadCount{
    LJHUserUnreadCountParam *param = [LJHUserUnreadCountParam param];
    param.uid = @([LJHAccountTool account].uid);
    
    [LJHUserTool userUnreadCountWithParam:param success:^(LJHUserUnreadCountResult *result) {
        if (result.status) {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        }
        if (result.messageCount) {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        }
        if (result.follower) {
            self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        }
        if (result.count) {
            [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
            }
        NSLog(@"%d",result.count);
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  推送本地通知
 */
//- (void)pushLocalNotification
//{
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    if (notification) {
//        // 设置通知的提醒时间
//        NSDate *currentDate   = [NSDate date];
//        notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
//        notification.fireDate = currentDate;
//        
//        // 设置重复间隔
//        notification.repeatInterval = NSCalendarUnitSecond;
//        
//        // 设置提醒的文字内容
//        notification.alertBody   = @"你有新的微博";
//        notification.alertAction = NSLocalizedString(@"看看呗", nil);
//        
//        // 通知提示音 使用默认的
//        notification.soundName= UILocalNotificationDefaultSoundName;
//        
//        // 设置应用程序右上角的提醒个数
//        notification.applicationIconBadgeNumber++;
//        
//        // 设定通知的userInfo，用来标识该通知
//        //                NSMutableDictionary *aUserInfo = [[NSMutableDictionary alloc] init];
//        //                aUserInfo[@"LocalNotificationID"] = @"LocalNotificationID";
//        //                notification.userInfo = aUserInfo;
//        
//        // 将通知添加到系统中
//        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//    }
//
//}

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
    [self setupChildVC:home title:@"首页" icon:@"tabbar_home" highIcon:@"tabbar_home_selected"];
    self.home = home;

    LJHMessageViewController *message = [[LJHMessageViewController alloc] init];
    [self setupChildVC:message title:@"消息" icon:@"tabbar_message_center" highIcon:@"tabbar_message_center_selected"];
    self.message = message;
    
    LJHDiscoverController *discover = [[LJHDiscoverController alloc] init];
    [self setupChildVC:discover title:@"广场" icon:@"tabbar_discover" highIcon:@"tabbar_discover_selected"];
    self.discover = discover;
    
    LJHMeViewController *me = [[LJHMeViewController alloc] init];
     [self setupChildVC:me title:@"我" icon:@"tabbar_profile" highIcon:@"tabbar_profile_selected"];
    self.me = me;
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
    LJHNavigationController *nav = [[LJHNavigationController alloc] initWithRootViewController:child];
    [self addChildViewController:nav];
    /**
     *  将子控制器所拥有的那个tabBarItem取出来传给自定义的tabBar来管理
     */
    [self.customTabBar addTabBarItem:child.tabBarItem];
}

#pragma mark - LJHTabBarDelegate
- (void)LJHTabBar:(LJHTabBar *)tabBar DidSelectTabBarButtonFrom:(int)from to:(int)to{
    self.selectedIndex = to;
    
    if (to == 0) {
        
        [self.home unreadCount];
    }
}

- (void)LJHTabBarDidClickedPlusButton:(LJHTabBar *)tabBar{
    LJHComposeViewController *composeVC = [[LJHComposeViewController alloc] init];
    LJHNavigationController *nav = [[LJHNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
