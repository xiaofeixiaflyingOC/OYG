//
//  BaseTopViewController.h
//  ZolSoft
//
//  Created by Dong Jian on 14-10-23.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseNavigatoinRootController : BaseViewController


/*
 * 是否因为从navigation stack中pop出来而调用的viewWillAppear
 * 只能在viewWillAppear中调用
 */
- (BOOL)isViewWillAppearBecauseOfPop;

- (BOOL)needsHiddenNavigationBarWhenAppear;

- (BOOL)needsHiddenNavigationBarWhenDisappear;

@end
