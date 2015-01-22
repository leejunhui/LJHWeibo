//
//  LJHUserUnreadCountResult.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/22.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  获取用户的各种消息未读数结果

#import <Foundation/Foundation.h>

/*
 status	int	新微博未读数
 follower	int	新粉丝数
 cmt	int	新评论数
 dm	int	新私信数
 mention_status	int	新提及我的微博数
 mention_cmt	int	新提及我的评论数
 group	int	微群消息未读数
 private_group	int	私有微群消息未读数
 notice	int	新通知未读数
 invite	int	新邀请未读数
 badge	int	新勋章数
 photo	int	相册消息未读数
 msgbox
 */

@interface LJHUserUnreadCountResult : NSObject
/**
 *  新微博未读数
 */
@property (assign, nonatomic) int status;
/**
 *  新粉丝数
 */
@property (assign, nonatomic) int follower;
/**
 *  新评论数
 */
@property (assign, nonatomic) int cmt;
/**
 *  新私信数
 */
@property (assign, nonatomic) int dm;
/**
 *  新提及我的微博数
 */
@property (assign, nonatomic) int mention_status;
/**
 *  新提及我的评论数
 */
@property (assign, nonatomic) int mention_cmt;

/**
 *  返回所有未读消息的总条数
 */
- (int)count;

/**
 *  返回消息里的未读消息条数
 */
- (int)messageCount;
@end
