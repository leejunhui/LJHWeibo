//
//  LJHOAuthTool.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHOAuthTool.h"

@implementation LJHOAuthTool
+ (void)OAuthWithParam:(LJHOAuthParam *)param success:(void (^)(LJHOAuthResult *))success failure:(void (^)(NSError *))failure{
    
    [LJHHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:param.keyValues success:^(id json) {
        if (success) {
            LJHOAuthResult *result = [LJHOAuthResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
