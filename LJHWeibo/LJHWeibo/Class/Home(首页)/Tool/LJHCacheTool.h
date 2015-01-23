//
//  LJHCacheTool.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/23.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJHHomeStatusesParam.h"
@class LJHStatus;
@interface LJHCacheTool : NSObject
/**
 *  缓存一条微博
 *
 *  @param status 需要缓存的微博数据
 */
+ (void)addStatus:(LJHStatus *)status;

/**
 *  缓存N条微博
 *
 *  @param statusArray 需要缓存的微博数据
 */
+ (void)addStatuses:(NSArray *)statusArray;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *
 *  @return 模型数组
 */
+ (NSArray *)statuesWithParam:(LJHHomeStatusesParam *)param;
@end
