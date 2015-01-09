//
//  LJHAppDelegate.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHAppDelegate.h"
#import "LJHTabBarController.h"
@implementation LJHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];  
    application.statusBarHidden = NO;
    self.window.rootViewController = [[LJHTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
