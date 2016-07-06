//
//  NetMonitor.m
//  AFNetworking3.0Test
//
//  Created by shengxin on 15/11/17.
//  Copyright © 2015年 shengxin. All rights reserved.
//

#import "NetMonitor.h"
#import <AFNetworking/AFNetworking.h>

static BOOL NeedsWaitingForReachabilityInitialize = NO;
static NSMutableArray *WaitingForReachabilityInitializeBlocks = nil;
static AFNetworkReachabilityStatus NetworkReachabilityStatus = AFNetworkReachabilityStatusUnknown;

@interface NetMonitor()

@property (nonatomic, assign) AFNetworkReachabilityStatus networkReachabilityStatus;

@end

@implementation NetMonitor


#pragma mark - public

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedInstance = [[[self class]alloc] init];
    });
    return _sharedInstance;
}

+ (void)startReachabilityMonitoring{
    NeedsWaitingForReachabilityInitialize = YES;
    WaitingForReachabilityInitializeBlocks = [NSMutableArray array];
    [self.reachabilityManager startMonitoring];
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NetworkReachabilityStatus = status;
        
        if (NeedsWaitingForReachabilityInitialize) {
            NeedsWaitingForReachabilityInitialize = NO;
            for (void (^callback)() in WaitingForReachabilityInitializeBlocks) {
                callback();
            }
            WaitingForReachabilityInitializeBlocks = nil;
        }
    }];

}

+ (BOOL)isReachable
{
    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
}

#pragma mark - private

//网络通过流量连接
+ (BOOL)isReachableViaWWAN
{
    return NetworkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN;
}

+ (BOOL)isReachableViaWiFi
{
    return NetworkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}

+ (AFNetworkReachabilityManager *)reachabilityManager
{
    return [AFNetworkReachabilityManager sharedManager];
}

@end
