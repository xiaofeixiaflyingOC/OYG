//
//  NavigationController.h
//  ZolSoft
//
//  Created by Dong Jian on 14-10-22.
//
//

#import <UIKit/UIKit.h>

/*
 * 继承于ZSNavigationController，可以加业务逻辑
 */

@interface BaseNavigationController : UINavigationController


+ (instancetype)controllerWithRootViewController:(UIViewController *)rootViewController;
@end