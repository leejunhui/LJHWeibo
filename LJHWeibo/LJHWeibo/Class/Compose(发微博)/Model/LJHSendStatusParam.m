//
//  LJHSendStatusParam.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHSendStatusParam.h"
@class IWFormData;
@implementation LJHSendStatusParam
//- (NSMutableArray *)formData{
//    if (_formData == nil) {
//        _formData = [NSMutableArray array];
//    }
//    return _formData;
//}

- (NSDictionary *)objectClassInArray{
    return @{@"formData": [IWFormData class]};
}
@end
