//
//  LJHUserTool.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJHUserInfoParam.h"
#import "LJHUserInfoResult.h"
@interface LJHUserTool : NSObject
/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userInfoWithParam:(LJHUserInfoParam *)param success:(void (^)(LJHUserInfoResult *result))success failure:(void (^)(NSError *error))failure;
@end
