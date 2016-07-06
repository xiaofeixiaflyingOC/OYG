//
//  NSString+Hash.h
//  ZAE
//
//  Created by C YH on 11-6-27.
//  Copyright 2011 ZOL. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Hash)

- (NSString *)md5;
- (NSUInteger)bkdr;
+ (NSString *)uuid;
+ (NSInteger)computation:(NSString *)text;

@end
