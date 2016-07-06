//
//  RootViewController.m
//  OYG
//
//  Created by shengxin on 16/7/4.
//  Copyright © 2016年 shengxin. All rights reserved.
//  首页 分类 市场 进货车 我的

#import "RootViewController.h"
#import "FirstViewController.h"
#import "MarketViewController.h"
#import "MyViewController.h"
#import "PurchaseCarViewController.h"
#import "SortViewController.h"
#import "BaseNavigationController.h"
#import "SPostModel.h"
#import "NSString+Hash.h"
#import "BaseDownLoadModel.h"
#import "SystemHelper.h"
#import "AppDelegate.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a/100.f]
#define TabBarItemTitleColor RGBA(101.0f, 105.0f, 110.0f, 100.0f)
#define TabBarItemTitleHighlightedColor RGBA(28.0f, 113.0f, 230.0f, 100.0f)
#define TabBarItemTitlePositionAdjustment UIOffsetMake(0, -3)
#define G_TitleFont  [UIFont fontWithName:@"Arial" size:18.0]
#define URL @"http://112.74.190.143/sign"

@interface RootViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) FirstViewController *firstController;
@property (nonatomic, strong) SortViewController *sortViewController;
@property (nonatomic, strong) MarketViewController *marketController;
@property (nonatomic, strong) PurchaseCarViewController *purchaseCarController;
@property (nonatomic, strong) MyViewController *myViewController;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTabBar];
//    
//    SPostModel *model = [[SPostModel alloc] init];
//    model.sname = @"zzzzzzzz";
//    model.sid = @"ddddddddd";
//    NSString *d = [[self getCurrentTimeStr] substringToIndex:7];
//    model.key = [[NSString stringWithFormat:@"%@%@%@",model.sid,model.sname,d] md5];
//    NetManager *manager = [[NetManager alloc] init];
//    
//    [manager requestMethod:@"GET" urlString:URL parameters:model completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
//        NSString *strJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        BaseDownLoadModel *model = [[BaseDownLoadModel alloc] initWithString:strJson error:nil];
//        NSLog(@"%@",model.message);
//    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SystemHelper changeLanguage:LanguageChinese];
//        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [delegate toMain];
//    });
}

-(NSString *)getCurrentTimeStr
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%d", (int)a];
    return timeString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -init
- (void)initTabBar{
    /*
     * tabBar 背景图设置
     */
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBar_bg"]];
    
    /*
     * tabBar 背景图阴影添加
     */
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tabBar_shadow"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : TabBarItemTitleColor}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : TabBarItemTitleHighlightedColor}
                                             forState:UIControlStateSelected];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:G_TitleFont}];
    self.delegate = self;
    self.viewControllers = @[[BaseNavigationController controllerWithRootViewController:self.firstController],
                            [BaseNavigationController controllerWithRootViewController:self.sortViewController],
                            [BaseNavigationController controllerWithRootViewController:self.marketController],
                             [BaseNavigationController controllerWithRootViewController:self.purchaseCarController],
                             [BaseNavigationController controllerWithRootViewController:self.myViewController]];
}

#pragma mark -Getter
- (FirstViewController*)firstController{
    if (_firstController==nil) {
        _firstController = [[FirstViewController alloc] initWithNibName:nil bundle:nil];
        _firstController.tabBarItem = [self tabBarItemWithTitle:Localized(@"HomePage")
                                         imageName:@"tabBarItem_pl"
                                 selectedImageName:@"tabBarItem_pl_selected"];
    }
    return _firstController;
}

- (SortViewController*)sortViewController{
    if (_sortViewController==nil) {
        _sortViewController = [[SortViewController alloc] initWithNibName:nil bundle:nil];
        _sortViewController.tabBarItem = [self tabBarItemWithTitle:Localized(@"Classification")
                                                      imageName:@"tabBarItem_pl"
                                              selectedImageName:@"tabBarItem_pl_selected"];
    }
    return _sortViewController;
}

- (MarketViewController*)marketController{
    if (_marketController==nil) {
        _marketController = [[MarketViewController alloc] initWithNibName:nil bundle:nil];
        _marketController.tabBarItem = [self tabBarItemWithTitle:Localized(@"Market")
                                                      imageName:@"tabBarItem_pl"
                                              selectedImageName:@"tabBarItem_pl_selected"];
    }
    return _marketController;
}

- (PurchaseCarViewController*)purchaseCarController{
    if (_purchaseCarController==nil) {
        _purchaseCarController = [[PurchaseCarViewController alloc] initWithNibName:nil bundle:nil];
        _purchaseCarController.tabBarItem = [self tabBarItemWithTitle:Localized(@"IntoTheTruck")
                                                         imageName:@"tabBarItem_pl"
                                                 selectedImageName:@"tabBarItem_pl_selected"];
    }
    return _purchaseCarController;
}

- (MyViewController*)myViewController{
    if (_myViewController==nil) {
        _myViewController = [[MyViewController alloc] initWithNibName:nil bundle:nil];
        _myViewController.tabBarItem = [self tabBarItemWithTitle:Localized(@"My")
                                                            imageName:@"tabBarItem_pl"
                                                    selectedImageName:@"tabBarItem_pl_selected"];
    }
    return _myViewController;
}

#pragma mark - utilities
- (UITabBarItem *)tabBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
    [item setSelectedImage:selectedImage];
    item.titlePositionAdjustment = TabBarItemTitlePositionAdjustment;
    return item;
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    NSUInteger tabBarIndex = tabBarController.selectedIndex;
    
    
}

#pragma mark - Screen Rotate
- (BOOL)shouldAutorotate{
    return [[self selectedViewController] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [[self selectedViewController] supportedInterfaceOrientations];
}

@end
