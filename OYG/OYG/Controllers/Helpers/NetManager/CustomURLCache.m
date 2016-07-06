//
//  CustomURLCache.m
//  AFNetworking3.0Test
//
//  Created by shengxin on 15/11/16.
//  Copyright © 2015年 shengxin. All rights reserved.
//

#import "CustomURLCache.h"

@implementation CustomURLCache


+ (instancetype)standarURLCache{
    static CustomURLCache *standCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        standCache = [[CustomURLCache alloc] initWithMemoryCapacity:(2*1024*1024) diskCapacity:(100*1024*1024) diskPath:nil];
    });
    return standCache;
}


@end
