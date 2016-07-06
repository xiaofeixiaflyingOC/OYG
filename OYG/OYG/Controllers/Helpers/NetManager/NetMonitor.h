//
//  NetMonitor.h
//  AFNetworking3.0Test
//
//  Created by shengxin on 15/11/17.
//  Copyright © 2015年 shengxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetMonitor : NSObject

+ (instancetype)sharedInstance;
+ (void)startReachabilityMonitoring;
+ (BOOL)isReachable;

@end
