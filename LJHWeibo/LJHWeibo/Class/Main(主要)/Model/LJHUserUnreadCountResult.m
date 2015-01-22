//
//  LJHUserUnreadCountResult.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/22.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHUserUnreadCountResult.h"

@implementation LJHUserUnreadCountResult

- (int)messageCount{
    return self.cmt + self.dm + self.mention_status + self.mention_cmt;
}

- (int)count{
    return self.messageCount + self.status + self.follower;
}

@end
