//
//  NSDate+LJH.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LJH)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
/**
 *  获取年月日格式的日期
 */
- (NSDate *)dateWithYMD;
@end
