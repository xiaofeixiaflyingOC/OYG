//
//  NSString+Helper.h
//  ASINetWork
//
//  Created by 盛 鑫 on 14-3-19.
//  Copyright (c) 2014年 盛 鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)


+ (BOOL)isBlankString:(NSString *)string;
+ (NSString*)transformCFNumber:(NSString*)string;
+(NSString*)DataTOjsonString:(id)object;
@end
