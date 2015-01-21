//
//  LJHOAuthTool.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJHOAuthParam.h"
#import "LJHOAuthResult.h"
@interface LJHOAuthTool : NSObject
/**
 *  进行OAuth授权
 */
+ (void)OAuthWithParam:(LJHOAuthParam *)param success:(void (^)(LJHOAuthResult *result))success failure:(void (^)(NSError *error))failure;
@end
