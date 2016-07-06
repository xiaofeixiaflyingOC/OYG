//
//  NavigationController.m
//  ZolSoft
//
//  Created by Dong Jian on 14-10-22.
//
//

#import "BaseNavigationController.h"

@interface BaseNavigationControllerBar : UINavigationBar

@end

@implementation BaseNavigationControllerBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
        if ([self respondsToSelector:@selector(backIndicatorImage)]) {
#endif
            self.backIndicatorImage = [UIImage imageNamed:@"navBarItem_back_white"];
            self.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navBarItem_back_white"];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
        }
#endif
    }
    return self;
}

@end

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (instancetype)controllerWithRootViewController:(UIViewController *)rootViewController
{
    id controller = [[[self class] alloc] initWithNavigationBarClass:[BaseNavigationControllerBar class]
                                                        toolbarClass:nil];
    [controller setViewControllers:@[rootViewController]];
    return controller;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;
//    /*
//     *统一调整导航title字体样式
//     */
//    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeFont:G_TitleFont}];
    
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}

- (BOOL)shouldAutorotate
{
    return [[self topViewController] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self topViewController] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{

 return [[self topViewController] preferredInterfaceOrientationForPresentation];

}

@end
