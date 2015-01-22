//
//  LJHUserTool.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHUserTool.h"
@implementation LJHUserTool
+ (void)userInfoWithParam:(LJHUserInfoParam *)param success:(void (^)(LJHUserInfoResult *))success failure:(void (^)(NSError *))failure{
    [LJHHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            LJHUserInfoResult *result = [LJHUserInfoResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userUnreadCountWithParam:(LJHUserUnreadCountParam *)param success:(void (^)(LJHUserUnreadCountResult *))success failure:(void (^)(NSError *))failure{
    [LJHHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param.keyValues success:^(id json) {
        if (success) {
            LJHUserUnreadCountResult *result = [LJHUserUnreadCountResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
