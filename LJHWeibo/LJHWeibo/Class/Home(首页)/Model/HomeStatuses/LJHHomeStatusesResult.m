//
//  LJHHomeStatusResult.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  封装加载首页微博数据的返回结果

#import "LJHHomeStatusesResult.h"
#import "LJHStatus.h"
@implementation LJHHomeStatusesResult
- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [LJHStatus class]};
}
@end
