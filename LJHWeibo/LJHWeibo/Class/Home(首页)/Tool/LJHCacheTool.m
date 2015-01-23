//
//  LJHCacheTool.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/23.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHCacheTool.h"
#import "LJHAccount.h"
#import "LJHAccountTool.h"
#import "LJHStatus.h"
#import <FMDB.h>
@interface LJHCacheTool()

@end
@implementation LJHCacheTool

static FMDatabaseQueue *_queue;

+(void)initialize{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        if([db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, access_token text, idstr text, dict blob);"] == YES){
            LJHLog(@"创表成功！");
        }
        else{
            LJHLog(@"创表失败!");
        }
    }];
}

+ (void)addStatuses:(NSArray *)statusArray
{
    for (NSDictionary *dict in statusArray) {
        [self addStatus:dict];
    }
}

+ (void)addStatus:(NSDictionary *)dict
{
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString *accessToken = [LJHAccountTool account].access_token;
        NSString *idstr = dict[@"idstr"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_status (access_token, idstr, dict) values(?, ? , ?)", accessToken, idstr, data];
    }];
}

+ (NSArray *)statuesWithParam:(LJHHomeStatusesParam *)param
{
    NSLog(@"%@ %@ %@",param.since_id, param.max_id,param.count);
    // 1.定义数组
    __block NSMutableArray *dictArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        dictArray = [NSMutableArray array];
        
        // accessToken
        NSString *accessToken = [LJHAccountTool account].access_token;
        
        FMResultSet *rs = nil;
        if (param.since_id) { // 如果有since_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;", accessToken, param.since_id, param.count];
        } else if (param.max_id) { // 如果有max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0,?;", accessToken, param.max_id, param.count];
        } else { // 如果没有since_id和max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?;", accessToken, param.count];
        }
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"dict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [dictArray addObject:dict];
        }
    }];
    
    // 3.返回数据
    return dictArray;
}
@end
