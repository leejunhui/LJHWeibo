//
//  LJHAccount.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHAccount.h"

@implementation LJHAccount
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        /**
         *  KVC
         */
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    return [[LJHAccount alloc] initWithDict:dict];
}


/**
 *  编码
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
}

/**
 *  解码
 */
- (id)initWithCoder:(NSCoder *)aDecoder; // NS_DESIGNATED_INITIALIZER
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in   = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.remind_in    = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.uid          = [aDecoder decodeInt64ForKey:@"uid"];
        self.expiresTime  = [aDecoder decodeObjectForKey:@"expiresTime"];
    }
    return self;
}
@end
