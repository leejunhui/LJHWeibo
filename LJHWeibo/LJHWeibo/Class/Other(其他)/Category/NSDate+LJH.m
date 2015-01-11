//
//  NSDate+LJH.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NSDate+LJH.h"

@implementation NSDate (LJH)
- (BOOL)isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    //1.获取当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

- (BOOL)isYesterday{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
//    //1.获取当前时间的年月日
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//    
//    //2.获得self的年月日
//    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
//    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
    return NO;
}

- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    //1.获取当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return (selfCmps.year == nowCmps.year);
}

- (NSDateComponents *)deltaWithNow{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end
