//
//  NetManager.m
//  AFNetworking3.0Test
//
//  Created by shengxin on 15/11/16.
//  Copyright © 2015年 shengxin. All rights reserved.
//

#import "NetManager.h"
#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModel.h>
#import "CustomURLCache.h"
#import "CacheHelper.h"
#import "NetMonitor.h"

@interface NetManager()

@property (nonatomic, strong) AFHTTPSessionManager *iSessionManager;
@property (nonatomic, strong) NSString *iUrlString;
@end

@implementation NetManager

#pragma mark - public

- (id)init{
    self = [super init];
    if (self) {
        [self initSessionManager];
    }
    return self;
}

+ (void)initCache{
    [NSURLCache setSharedURLCache:[CustomURLCache standarURLCache]];
}

- (void)requestMethod:(NSString*)method
            urlString:(NSString*)urlString
            parameters:(id)parameters
            completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completion{

    self.iUrlString = urlString;
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.requestCachePolicy =  NSURLRequestReturnCacheDataElseLoad;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfig];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    //传入的model转成NSDictionary
    NSDictionary *dict = [parameters toDictionary];
    //无网络去数据库读取a,b,将dict中a,b去掉生成url
    if ([NetMonitor isReachable]==NO) {
        //得到缓存数组arrayAandB
        NSMutableArray *arrayAandB = [self getCacheData:dict];
        NSMutableDictionary *dict1 = [self getNoAandBDict:dict];
        
        if (arrayAandB.count!=0) {
            //将a，b加入到字典中
        [dict1 setObject:[arrayAandB objectAtIndex:0] forKey:@"key"];

        NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:urlString parameters:dict1 error:nil];

        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                        completionHandler:
                                              ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                  completion(data,response,error);
                                              }];  
            // 使用resume方法启动任务  
            [dataTask resume];
        }else{
           //无网络第二种情况开启前网络监测没有完成就执行加载
            NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:urlString parameters:dict error:nil];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                        completionHandler:
                                              ^(NSData *data, NSURLResponse *response, NSError *error) {
                                             
                                                  if (error==nil) {
                                                      [self saveCache:dict];
                                                  }
                                                  completion(data,response,error);
                                              }];
            
            [dataTask resume];
        }
    }else{
        //无网络第二种情况开启前网络监测没有完成就执行加载
        NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:urlString parameters:dict error:nil];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:
                                          ^(NSData *data, NSURLResponse *response, NSError *error) {
                                             
                                              if (error==nil) {
                                                  [self saveCache:dict];
                                              }
                                              completion(data,response,error);
                                          }];
        
        [dataTask resume];
    }
}

#pragma mark - private

- (void)initSessionManager{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.requestCachePolicy =  NSURLRequestReturnCacheDataElseLoad;
    self.iSessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfig];
}

//存储缓存 传入的dict带有a，b
- (void)saveCache:(NSDictionary*)dict {
    NSString *a = [dict objectForKey:@"key"];

    //得到无a,b的url进行插入
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    for(id key in dict){
        NSString *key1 = (NSString*)key;
        if (!([key1 isEqualToString:@"key"])) {
            [dict1 setObject:[dict objectForKey:key1] forKey:key1];
        }
    }
    NSString *url = [[AFHTTPRequestSerializer serializer] QueryStringFromParametersWithEncoding:dict1];
     NSString *newUrl = [NSString stringWithFormat:@"%@&%@",self.iUrlString,url];
    [[CacheHelper shareInstance] insertCacheUrl:newUrl andA:a];
}

//读缓存
- (NSMutableArray*)getCacheData:(NSDictionary*)dict{
    NSMutableDictionary *dict1 = [self getNoAandBDict:dict];
    NSString *url = [[AFHTTPRequestSerializer serializer] QueryStringFromParametersWithEncoding:dict1];
    NSString *newUrl = [NSString stringWithFormat:@"%@&%@",self.iUrlString,url];
    NSMutableArray * arrayAandB  = [[CacheHelper shareInstance] getAandB:newUrl];
    return arrayAandB;
}

//得到没有A，B的字典
- (NSMutableDictionary*)getNoAandBDict:(NSDictionary*)dict{
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    for(id key in dict){
        NSString *key1 = (NSString*)key;
        if (!([key1 isEqualToString:@"key"])) {
            [dict1 setObject:[dict objectForKey:key1] forKey:key1];
        }
    }
    return dict1;
}

@end
