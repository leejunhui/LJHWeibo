//
//  LJHStatusTool.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJHHomeStatusesParam.h"
#import "LJHHomeStatusesResult.h"
@interface LJHStatusTool : NSObject
+ (void)homeStatusesWithParam:(LJHHomeStatusesParam *)param success:(void (^)(LJHHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;
@end
