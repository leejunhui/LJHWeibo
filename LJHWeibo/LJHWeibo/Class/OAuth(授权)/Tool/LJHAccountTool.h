//
//  LJHAccountTool.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJHAccount;
@interface LJHAccountTool : NSObject
/**
 *  保存账户信息
 *
 *  @param account 账户
 */
+ (void)saveAccount:(LJHAccount *)account;

/**
 *  返回保存的账户信息
 */
+ (LJHAccount *)account;
@end
