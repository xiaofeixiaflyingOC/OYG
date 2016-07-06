//
//  CacheHelper.h
//  AFNetworking3.0Test
//
//  Created by shengxin on 15/11/16.
//  Copyright © 2015年 shengxin. All rights reserved.
//

/* 
 缓存逻辑：
 insertCacheUrl 传入的aUrl是不带有a，b加密串的，表中存储urlKey 即url md5值后值，插入时先判断
 是否有相同的key，如果有删除，再插入；否则直接插入。
 补充说明：列表页下拉刷新操作，page=1的urlkey行值进行替换，page=2数据无网络情况下不更新，显示的时候只显示page=1的数据。
 deleteAllCache 删除所有表中数据
 getAandB 根据aUrl 查询a，b 以数组形式返回
 */
 




#import <Foundation/Foundation.h>

@interface CacheHelper : NSObject

+ (instancetype) shareInstance;
- (BOOL)insertCacheUrl:(NSString*)aUrl andA:(NSString*)a;
- (BOOL)deleteAllCache;
- (NSMutableArray*)getAandB:(NSString*)aUrl;



@end
