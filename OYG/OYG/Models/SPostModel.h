//
//  SPostModel.h
//  YiGouExample
//
//  Created by shengxin on 16/6/21.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SPostModel : JSONModel

@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *sname;
@property (nonatomic, strong) NSString *key;

@end
