//
//  LJHStatusTool.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJHHomeStatusesParam;

@interface LJHStatusTool : NSObject
+ (void)homeStatusesWithParam:(LJHHomeStatusesParam *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
