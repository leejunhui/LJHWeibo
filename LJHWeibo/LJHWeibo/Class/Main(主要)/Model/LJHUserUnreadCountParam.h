//
//  LJHUserUnreadCountParam.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/22.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  获取用户的各种消息未读数参数

#import <Foundation/Foundation.h>
@class LJHBaseParam;
@interface LJHUserUnreadCountParam : LJHBaseParam
/**
 *  需要获取消息未读数的用户UID，必须是当前登录用户。
 */
@property (strong, nonatomic) NSNumber *uid;
@end
