//
//  AppDelegate.h
//  OYG
//
//  Created by shengxin on 16/7/4.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootViewController *rootViewController;

//切换root 语言配置 先暂定切root吧后期优化
- (void)toMain;
@end

