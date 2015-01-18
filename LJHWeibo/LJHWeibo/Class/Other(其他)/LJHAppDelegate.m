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
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];  
    [self.window makeKeyAndVisible];
    
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

    
    return YES;
}

/**
 *  当app收到内存警告时，清理图片缓存
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];;
}


@end
