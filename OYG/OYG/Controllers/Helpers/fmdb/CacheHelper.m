//
//  CacheHelper.m
//  AFNetworking3.0Test
//
//  Created by shengxin on 15/11/16.
//  Copyright © 2015年 shengxin. All rights reserved.
//

#import "CacheHelper.h"
#import "FMDB.h"
#import "NSString+Helper.h"
#import "NSString+Hash.h"

@interface CacheHelper()
{
    FMDatabaseQueue* queue;
}

@end


@implementation CacheHelper

#pragma mark - public

-(id) init
{
    self = [super init];
    if(self){
        NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"Cache30sCarDB.db"];
        queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return self;
}

+ (instancetype) shareInstance{
    static dispatch_once_t onceToken;
    static CacheHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[CacheHelper alloc] init];
    });
    return instance;
}

- (BOOL)insertCacheUrl:(NSString*)aUrl andA:(NSString*)a{
    __block BOOL state;
   [self createCollectionTable];
    if([self searchCacheUrl:aUrl]==YES){
       [self deleteCacheUrl:aUrl];
    }
    [queue inDatabase:^(FMDatabase *db) {
       state = [db executeUpdate:@"INSERT INTO Cache30sCar(key,urlKey) VALUES (?,?)",a,[aUrl md5]];
    }];
    return state;
}

- (BOOL)deleteAllCache{
    __block BOOL state;
    [queue inDatabase:^(FMDatabase *db) {
      state = [db executeUpdate:@"DELETE FROM Cache30sCar"];
    }];
    return state;
}

- (NSMutableArray*)getAandB:(NSString*)aUrl{
    NSMutableArray *array = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *key = [aUrl md5];
        FMResultSet *s;
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Cache30sCar where urlKey ='%@'",key];
        s = [db executeQuery:sql];
        while ([s next]) {
            NSString *a = [s stringForColumn:@"key"];
            [array addObject:a];
        }
    }];
    return array;
}

#pragma mark - private

- (void)createCollectionTable{

    [queue inDatabase:^(FMDatabase *db) {
        //创建表
        NSString *sql = nil;
        sql = @"create table Cache30sCar (id integer primary key autoincrement,key text,urlKey text);";
        BOOL createTableResult=[db executeUpdate:sql];
        if (createTableResult) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
        }
    }];
}

- (BOOL)searchCacheUrl:(NSString*)aUrl{
     __block  BOOL state;
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *key = [aUrl md5];
        FMResultSet *s;
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Cache30sCar where urlKey ='%@'",key];
        s = [db executeQuery:sql];
        while ([s next]) {
            state = YES;
        }
    }];
    return state;
}

- (BOOL)deleteCacheUrl:(NSString*)aUrl{
    __block BOOL state;
    [queue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM Cache30sCar WHERE urlKey ='%@'",[aUrl md5] ];
       state = [db executeUpdate:sql];
    }];
    return state;
}

@end
