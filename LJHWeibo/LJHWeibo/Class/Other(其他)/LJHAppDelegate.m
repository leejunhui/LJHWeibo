//
//  LJHAppDelegate.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHAppDelegate.h"
#import "LJHWeiboTool.h"
#import "LJHAccountTool.h"
#import "LJHAccount.h"
#import "LJHOAuthViewController.h"
@implementation LJHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.isCached = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.window makeKeyAndVisible];
    
    if(iOS8)
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    //判断是否已授权
    LJHAccount *account = [LJHAccountTool account];
    
    if (account)//已授权
    {
        //再判断是否是最新版本
        [LJHWeiboTool chooseRootController];
    }
    else
    {
        self.window.rootViewController = [[LJHOAuthViewController alloc] init];
    }

    //4.监控网络状态
    AFNetworkReachabilityManager *mgr=[AFNetworkReachabilityManager sharedManager];
    //当网络状态改变的时候，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown://未知网络
            case AFNetworkReachabilityStatusNotReachable://没有网络
                LJHLog(@"没有网络（断网）");
                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://手机自带网络
                LJHLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi://WIFI
                LJHLog(@"WIFI");
                break;
        }
    }];
    //开始监控
    [mgr startMonitoring];
    
    return YES;
}

/**
 *  当app收到内存警告时，清理图片缓存
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];;
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
    }];
}


@end
