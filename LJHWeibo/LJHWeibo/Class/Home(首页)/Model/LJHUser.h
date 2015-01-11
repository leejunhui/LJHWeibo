//
//  LJHUser.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJHUser : NSObject
/**
 *  用户id
 */
@property (copy, nonatomic) NSString *idstr;
/**
 *  用户名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  用户头像
 */
@property (copy, nonatomic) NSString *profile_image_url;
/**
 *  会员等级
 */
@property (assign, nonatomic) int mbrank;
/**
 *  会员类型
 */
@property (assign, nonatomic) int mbtype;
@end
