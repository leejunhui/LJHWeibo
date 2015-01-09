//
//  LJHAccount.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJHAccount : NSObject<NSCoding>
/**
 *  用于调用access_token，接口获取授权后的access token
 */
@property (copy, nonatomic) NSString *access_token;
/**
 *  access_token的生命周期，单位是秒数
 */
@property (assign, nonatomic) long long expires_in;
/**
 *  access_token的生命周期（该参数即将废弃，开发者请使用expires_in
 */
@property (assign, nonatomic) long long remind_in;
/**
 *  当前授权用户的UID
 */
@property (assign, nonatomic) long long uid;
/**
 *  账号的过期时间
 */
@property (strong, nonatomic) NSDate *expiresTime;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
