//
//  NetManager.h
//  AFNetworking3.0Test
//
//  Created by shengxin on 15/11/16.
//  Copyright © 2015年 shengxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject

+ (void)initCache;

- (void)requestMethod:(NSString*)method
            urlString:(NSString*)urlString
           parameters:(id)parameters
    completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completion;

@end
