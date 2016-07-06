//
//  NSString+Hash.m
//  ZAE
//
//  Created by C YH on 11-6-27.
//  Copyright 2011 ZOL. All rights reserved.
//

#import "NSString+Hash.h"
#import <CommonCrypto/CommonDigest.h>


// BKDR Hash
unsigned int BKDRHash(const char *str)
{
	unsigned int seed =131; // 31 131 1313 13131 131313 etc..unsigned int 
	unsigned int hash = 0;
	while(*str) {
		hash = hash * seed + (*str++);
	}
	return (hash & 0x7FFFFFFF);
}


@implementation NSString (Hash)

- (NSString *)md5
{
	const char *str = [self UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], 
			r[10], r[11], r[12], r[13], r[14], r[15]];
}

- (NSUInteger)bkdr
{
	const char *str = [self UTF8String];
	return BKDRHash(str);
}

+ (NSString *)uuid
{
	CFUUIDRef u = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef s = CFUUIDCreateString(kCFAllocatorDefault, u);
	CFRelease(u);
	return [(__bridge NSString *)s autorelease];
}

/**
 *  计算剩余数量
 *
 *  @author zhouyu
 *  @version v4.0.0
 *  @param text 需要计算的字符串
 *  @return 返回个数
 *  @修改历史
 *   修改版本    作者名     修改明细
 */
+ (NSInteger)computation:(NSString *)text
{
    NSInteger chinaword = 0;
    int i;
    for(i = 0; i < [text length]; i++){
        int a = [text characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            chinaword++;
        }
    }
    NSInteger engw = [text length] - chinaword;
    return (chinaword + (engw/2));
}

@end
