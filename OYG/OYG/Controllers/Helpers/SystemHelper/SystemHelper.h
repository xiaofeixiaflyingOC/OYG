//
//  SystemHelper.h
//  OYG
//
//  Created by shengxin on 16/7/6.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    LanguageEn = 0,
    LanguageChinese
}LanguageType;

@interface SystemHelper : NSObject


+(instancetype)shareInstance;
//语言设置
+(void)initLanguage;
+(void)changeLanguage:(LanguageType)aType;
+(LanguageType)getCurrentLanguage;


@end
