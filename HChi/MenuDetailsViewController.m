//
//  MenuDetailsViewController.m
//  HChi
//
//  Created by uniQue on 16/1/27.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "MenuDetailsViewController.h"
#import "CustomViewController.h"

@interface MenuDetailsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * detailsTableView;
@property (nonatomic, strong) NSArray * detailsData;

@end

@implementation MenuDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [HCNCBackgroundForSubView removeFromSuperview];
}

- (void)initView {
    _detailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStyleGrouped];
    _detailsTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _detailsTableView.tableFooterView = [UIView new];
    
    _detailsTableView.delegate = self;
    _detailsTableView.dataSource = self;
    
    _detailsTableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    _detailsTableView.showsVerticalScrollIndicator = false;
    
    [_detailsTableView registerClass:[MenuDetailsCell class] forCellReuseIdentifier:@"cell"];
    [_detailsTableView registerNib:[UINib nibWithNibName:@"MenuDetailsCell" bundle:nil] forCellReuseIdentifier:@"CookCell"];
    [self.view addSubview:_detailsTableView];
    
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"MenuDetails" ofType:@"plist"];
    _detailsData = [[NSArray alloc] initWithContentsOfFile:path];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换模式" style:UIBarButtonItemStyleDone target:self action:@selector(changeMode)];
}

- (void)changeMode {
    [self.navigationController pushViewController:[BigPictureModeViewController new] animated:true];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _detailsData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_detailsData[section][0][@"content"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section != 2) {
        MenuDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSArray * arr = _detailsData[indexPath.section][0][@"content"];
        [cell configureCellWithArray:arr withIndex:indexPath];
        return cell;
    } else {
        MenuDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CookCell"];
        NSArray * arr = _detailsData[indexPath.section][0][@"content"];
        [cell configureCellWithArray:arr withIndex:indexPath];
        return cell;
    }
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView * headView = [[NSBundle mainBundle] loadNibNamed:@"MenuDetailsHeadView" owner:self options:nil].firstObject;
        headView.backgroundColor = [UIColor clearColor];
        return headView;
    }
    return nil;
}

#pragma mark -UITableViewDelegate
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _detailsData[section][0][@"headTitle"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        MenuDetailsCell * cell = (MenuDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView * headView = [[NSBundle mainBundle] loadNibNamed:@"MenuDetailsHeadView" owner:self options:nil].firstObject;
        return headView.frame.size.height;
    }
    return 40;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
