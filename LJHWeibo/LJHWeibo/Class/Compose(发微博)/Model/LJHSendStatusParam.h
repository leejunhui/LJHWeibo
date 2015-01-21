//
//  LJHSendStatusParam.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  封装发微博的参数

#import "LJHBaseParam.h"

@interface LJHSendStatusParam : LJHBaseParam

/**
 *  要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic, copy) NSString *status;

/**
 *  图片数据
 */
@property (strong, nonatomic) NSMutableArray *formData;
@end
