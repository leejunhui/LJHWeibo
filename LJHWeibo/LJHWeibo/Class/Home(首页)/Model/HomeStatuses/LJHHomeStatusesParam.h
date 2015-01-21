//
//  LJHHomeStatusesParam.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJHHomeStatusesParam : LJHBaseParam
/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property (nonatomic, assign) NSNumber *since_id;

/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic, assign) NSNumber *max_id;

/**
 *  单页返回的记录条数，最大不超过100，默认为20。
 */
@property (nonatomic, assign) NSNumber *count;
@end
