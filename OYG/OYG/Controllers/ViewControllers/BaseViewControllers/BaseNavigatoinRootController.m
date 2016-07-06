//
//  BaseTopViewController.m
//  ZolSoft
//
//  Created by Dong Jian on 14-10-23.
//
//

#import "BaseNavigatoinRootController.h"

@interface BaseNavigatoinRootController ()

@end

@implementation BaseNavigatoinRootController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([ZSSystemHelper deviceSystemMajorVersion] < 7) {
        [self.navigationController setNavigationBarHidden:[self needsHiddenNavigationBarWhenAppear]];
    } else {
#endif
        if (self.isViewWillAppearBecauseOfPop) {
            [self.navigationController setNavigationBarHidden:[self needsHiddenNavigationBarWhenAppear] animated:YES];
        } else {
            //from tab bar
            [self.navigationController setNavigationBarHidden:[self needsHiddenNavigationBarWhenAppear] animated:NO];
        }
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    }
#endif
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:[self needsHiddenNavigationBarWhenDisappear]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)needsHiddenNavigationBarWhenAppear
//{
//    return YES;
//}

- (BOOL)needsHiddenNavigationBarWhenDisappear
{
    return NO;
}

- (BOOL)needsCustomBackBarButtonItem
{
    return NO;
}

//- (BOOL)isViewWillAppearBecauseOfPop
//{
//    return [self.navigationController.view window] && !self.isMovingToParentViewController;
//}


- (BOOL)isViewWillAppearBecauseOfPop{
    return YES;
}

- (BOOL)needsHiddenNavigationBarWhenAppear
{
    return YES;
}

@end
