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
#import "LJHAppDelegate.h"
@implementation LJHStatusTool
+ (void)homeStatusesWithParam:(LJHHomeStatusesParam *)param success:(void (^)(LJHHomeStatusesResult *result))success failure:(void (^)(NSError *))failure
{
    
    //思路：不管有没有网，先看有没有缓存，如果没有缓存，则发请求，如果有，则加载缓存。。这一步完了之后，以后就要检测
    //有没有网络，如果有网，发请求，如果没网，要分情况，如果是请求最新的，则无反应，如果是请求以前的并已经缓存过的，则加载缓存
    
    //0.监控网络状态
    AFNetworkReachabilityManager *mgr=[AFNetworkReachabilityManager sharedManager];
    if (mgr.reachable == NO) { //断网
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
        else //无缓存
        {
            NSError *error = nil;
            failure(error);
            [MBProgressHUD showError:@"网络异常，无法加载更多!"];
        }
    }
    else { //联网
        NSArray *statusArray = [LJHCacheTool statuesWithParam:param];
        NSLog(@"数据库内有多少条%d",(int)statusArray.count);
        if (statusArray.count) { // 有缓存
            // 传递了block
            if (success) {
                LJHHomeStatusesResult *result = [[LJHHomeStatusesResult alloc] init];
                result.statuses = [LJHStatus objectArrayWithKeyValuesArray:statusArray];
                success(result);
            }
        } else {  //没有缓存
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
}

+ (void)sendStatusWithParam:(LJHSendStatusParam *)param success:(void (^)(LJHSendStatusResult *))success failure:(void (^)(NSError *))failure{
    NSLog(@"FORMDATA:%@",param.formData);
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
