//
//  LJHStatusTool.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  微博业务处理类（工具类）

#import <Foundation/Foundation.h>
#import "LJHHomeStatusesParam.h"
#import "LJHHomeStatusesResult.h"
#import "LJHSendStatusParam.h"
#import "LJHSendStatusResult.h"
@interface LJHStatusTool : NSObject
/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeStatusesWithParam:(LJHHomeStatusesParam *)param success:(void (^)(LJHHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一条微博
 */
+ (void)sendStatusWithParam:(LJHSendStatusParam *)param success:(void (^)(LJHSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end
