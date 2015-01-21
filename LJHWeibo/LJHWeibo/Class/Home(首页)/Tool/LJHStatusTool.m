//
//  LJHStatusTool.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHStatusTool.h"
#import "LJHHttpTool.h"
@implementation LJHStatusTool
+ (void)homeStatusesWithParam:(LJHHomeStatusesParam *)param success:(void (^)(LJHHomeStatusesResult *result))success failure:(void (^)(NSError *))failure
{
    [LJHHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
        if (success) {
            LJHHomeStatusesResult *result = [LJHHomeStatusesResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
