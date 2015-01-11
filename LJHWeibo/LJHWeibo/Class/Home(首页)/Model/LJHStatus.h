//
//  LJHStatus.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  微博模型

#import <Foundation/Foundation.h>
@class LJHUser;
@interface LJHStatus : NSObject
/**
 *  微博id
 */
@property (copy, nonatomic) NSString *idstr;
/**
 *  微博正文
 */
@property (copy, nonatomic) NSString *text;
/**
 *  微博来源
 */
@property (copy, nonatomic) NSString *source;
/**
 *  微博的时间
 */
@property (copy, nonatomic) NSString *created_at;
/**
 *  微博转发数
 */
@property (assign, nonatomic) int reposts_count;
/**
 *  微博评论数
 */
@property (assign, nonatomic) int comments_count;
/**
 *  微博表态数(点赞数)
 */
@property (assign, nonatomic) int attitudes_count;
/**
 *  微博作者
 */
@property (strong, nonatomic) LJHUser *user;
/**
 *  微博的单张配图
 */
@property (copy, nonatomic) NSString *thumbnail_pic;
/**
 *  被转发的微博
 */
@property (strong, nonatomic) LJHStatus *retweeted_status;
@end
