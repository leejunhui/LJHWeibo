//
//  LJHAccountTool.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHAccountTool.h"
#import "LJHAccount.h"
#define LJHAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation LJHAccountTool
+ (void)saveAccount:(LJHAccount *)account{
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:LJHAccountFile];
}


+ (LJHAccount *)account{
    LJHAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:LJHAccountFile];
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending)//未过期
    {
        return account;
    }
    else //过期
    {
        return nil;
    }
}
@end
