//
//  SystemHelper.m
//  OYG
//
//  Created by shengxin on 16/7/6.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "SystemHelper.h"

@interface SystemHelper()

@end

@implementation SystemHelper

#pragma mark - public
+(instancetype)shareInstance{
    static SystemHelper *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[SystemHelper alloc] init];
    });
    return obj;
}

+(void)initLanguage{
    //第一次根据本地语言设置
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]) {
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
        if ([language hasPrefix:@"zh-Hans"]) {//开头匹配
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(void)changeLanguage:(LanguageType)aType{
    if (aType==LanguageEn) {
         [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(LanguageType)getCurrentLanguage{
    NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"];
    if ([type isEqualToString:@"en"]) {
        return LanguageEn;
    }else{
        return LanguageChinese;
    }
}



@end
