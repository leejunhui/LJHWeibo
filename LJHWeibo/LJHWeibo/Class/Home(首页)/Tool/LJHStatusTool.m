//
//  LJHStatusTool.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHStatusTool.h"
#import "LJHHttpTool.h"
#import "LJHCacheTool.h"
@implementation LJHStatusTool
+ (void)homeStatusesWithParam:(LJHHomeStatusesParam *)param success:(void (^)(LJHHomeStatusesResult *result))success failure:(void (^)(NSError *))failure
{
//     1.先从缓存里面加载
    NSArray *statusArray = [LJHCacheTool statuesWithParam:param];
    NSLog(@"数据库内有多少条%d",(int)statusArray.count);
    if (statusArray.count) { // 有缓存
        // 传递了block
        if (success) {
            LJHHomeStatusesResult *result = [[LJHHomeStatusesResult alloc] init];
            result.statuses = [LJHStatus objectArrayWithKeyValuesArray:statusArray];
            success(result);
        }
    }
    else {
        [LJHHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
            if (success) {
                
                
                LJHHomeStatusesResult *result = [LJHHomeStatusesResult objectWithKeyValues:json];
                // 缓存
                [LJHCacheTool addStatuses:json[@"statuses"]];

                
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

+ (void)sendStatusWithParam:(LJHSendStatusParam *)param success:(void (^)(LJHSendStatusResult *))success failure:(void (^)(NSError *))failure{
    if (param.formData == nil) {
        [LJHHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
            if (success) {
                LJHSendStatusResult *result = [LJHSendStatusResult objectWithKeyValues:json];
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
    else
    {
        [LJHHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" params:param.keyValues formDataArray:param.formData success:^(id json) {
            if (success) {
                LJHSendStatusResult *result = [LJHSendStatusResult objectWithKeyValues:json];
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
        LJHLog(@"有图片要发送!");
    }

}

@end
