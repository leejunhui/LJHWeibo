//
//  LJHWeiboTool.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHWeiboTool.h"
#import "LJHNewFeatureController.h"
#import "LJHTabBarController.h"
@implementation LJHWeiboTool
+ (void)chooseRootController{
    NSString *key = @"CFBundleVersion";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion  = [userDefaults valueForKey:key];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion])
    {
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LJHTabBarController alloc] init];
    }
    else
    {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LJHNewFeatureController alloc] init];
        [userDefaults setObject:currentVersion forKey:key];
        [userDefaults synchronize];
    }
}
@end
