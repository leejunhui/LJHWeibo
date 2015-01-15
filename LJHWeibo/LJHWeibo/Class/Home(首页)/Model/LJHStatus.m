//
//  LJHStatus.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHStatus.h"
#import "NSDate+LJH.h"
#import "LJHPhoto.h"
@implementation LJHStatus


- (NSDictionary *)objectClassInArray{
    return @{@"pic_urls": [LJHPhoto class]};
}


/**
 *  重写getter方法 Sun Jan 11 20:15:37 +0800 2015
EEE MMM dd HH:mm:ss Z yyyy
 _created_at	NSString *	@"Mon Jan 12 10:28:23 +0800 2015"	0x0000000170057100
 */
- (NSString *)created_at{
    
//    NSLog(@"%@",_created_at);
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    fmt.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];
    NSDate *createDate = [fmt dateFromString:_created_at];
//    NSLog(@"%@",createDate);
    //2.判断微博的发送时间和现在时间的差距
    if ([createDate isToday]) { //今天
        if ([createDate deltaWithNow].hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前",(long)[createDate deltaWithNow].hour];
        } else if([createDate deltaWithNow].minute >=1){
            return [NSString stringWithFormat:@"%ld分钟前",(long)[createDate deltaWithNow].minute];
        }
        else {
            return @"刚刚";
        }
    } else if ([createDate isYesterday]){ //昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createDate];
    } else if ([createDate isThisYear]) { //今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    } else { //非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

/**
 *  为了性能优化处理,这里采取重写setter方法，只需在字典转模型的过程中一次就可获得source
 */
- (void)setSource:(NSString *)source{
    int startLoc = (int)[source rangeOfString:@">"].location + 1;
    int length = (int)[source rangeOfString:@"</"].location - startLoc;
    _source =  [NSString stringWithFormat:@"来自%@",[source substringWithRange:NSMakeRange(startLoc, length)]];
}


@end
