
//
//  BaseViewController.m
//  YiGouExample
//
//  Created by shengxin on 16/6/20.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
     
        self.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"返回";
        self.navigationItem.backBarButtonItem = backItem;
    }
    
    return self;
}


- (BOOL)isViewWillAppearBecauseOfPop{
    return YES;
}

- (BOOL)needsHiddenNavigationBarWhenAppear
{
    return NO;
}
@end
