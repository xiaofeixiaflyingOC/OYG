//
//  FirstViewController.m
//  OYG
//
//  Created by shengxin on 16/7/4.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "FirstViewController.h"
#import "HYSegmentedControl.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,HYSegmentedControlDelegate>

@property (nonatomic, strong) UITableView *iTableView;
@property (nonatomic, strong) HYSegmentedControl *iHYSegmentedControl;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -init
- (void)initTableView{
    self.iTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    self.iTableView.delegate = self;
    self.iTableView.dataSource = self;
    [self.view addSubview:self.iTableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    view.backgroundColor = [UIColor orangeColor];
    self.iTableView.tableHeaderView = view ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"identifer1";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.iHYSegmentedControl = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"上线时间", @"人气排行", @"为您推荐", @"猜您喜欢", @"最多评价", @"上线时间", @"人气排行", @"为您推荐", @"猜您喜欢", @"最多评价"] delegate:self] ;
    self.iHYSegmentedControl.delegate = self;
    return self.iHYSegmentedControl;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0;
}

#pragma mark - HYSegmentedControlDelegate
//代理函数 获取当前下标
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index{
    
}
@end
