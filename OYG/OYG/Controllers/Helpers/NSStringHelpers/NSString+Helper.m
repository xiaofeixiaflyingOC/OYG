//
//  NSString+Helper.m
//  ASINetWork
//
//  Created by 盛 鑫 on 14-3-19.
//  Copyright (c) 2014年 盛 鑫. All rights reserved.
//

#import "NSString+Helper.h"


@implementation NSString (Helper)

+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
    {
        return YES;
    }
    else if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    else
    {
       return NO;
    }
}

+ (NSString*)transformCFNumber:(NSString*)string
{
    NSString *tempString = [NSString stringWithFormat:@"%@",string];
    return tempString;
}

+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
