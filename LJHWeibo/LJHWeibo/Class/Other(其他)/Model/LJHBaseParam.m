//
//  LJHBaseParam.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHBaseParam.h"
#import "LJHAccount.h"
#import "LJHAccountTool.h"
@implementation LJHBaseParam
- (id)init
{
    if (self = [super init]) {
        self.access_token = [LJHAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end
