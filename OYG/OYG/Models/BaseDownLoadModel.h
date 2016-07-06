//
//  BaseDownLoadModel.h
//  YiGouExample
//
//  Created by shengxin on 16/6/21.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BaseDownLoadModel : JSONModel

@property (nonatomic, assign) BOOL status;
@property (nonatomic, assign) NSDictionary *message;
@end
