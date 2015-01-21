//
//  LJHOAuthParam.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
@interface LJHOAuthParam : NSObject
/**
 *  申请应用时分配的AppKey
 */
@property (copy, nonatomic) NSString *client_id;
/**
 *  申请应用时分配的AppSecret
 */
@property (copy, nonatomic) NSString *client_secret;
/**
 *  请求的类型，填写authorization_code
 */
@property (copy, nonatomic) NSString *grant_type;
/**
 *  调用authorize获得的code值
 */
@property (copy, nonatomic) NSString *code;
/**
 *  回调地址，需需与注册应用里的回调地址一致
 */
@property (copy, nonatomic) NSString *redirect_uri;
+ (instancetype)param;
@end
