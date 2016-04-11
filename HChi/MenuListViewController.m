//
//  MenuListViewController.m
//  HChi
//
//  Created by uniQue on 16/1/18.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "MenuListViewController.h"
#import "CustomViewController.h"

static NSString * const MenuListViewCellIdentifier = @"ListCell";

@interface MenuListViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) TableViewDataSource * tableViewDataSource;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation MenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
    
    [self.navigationItem setTitle:_navTitleText];
    [self initView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [HCNCBackgroundForSubView removeFromSuperview];
}

- (void)initView {
    
#pragma mark 创建列表
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStylePlain];
    
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor clearColor];
    
    TableViewCellConfigureBlock listCellConfigureBlock = ^(MenuListTableViewCell * listCell, NSDictionary * dic, NSIndexPath * row){
        [listCell configureCellWithDic:dic];
    };
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"MenuList" ofType:@"plist"];
    _dataArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    self.tableViewDataSource = [[TableViewDataSource alloc] initWithItems:_dataArray cellIdentifier:MenuListViewCellIdentifier cellBlock:listCellConfigureBlock];
    
    _tableView.delegate = self;
    _tableView.dataSource = self.tableViewDataSource;
    
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.showsVerticalScrollIndicator = false;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MenuListViewCell" bundle:nil] forCellReuseIdentifier:MenuListViewCellIdentifier];
    [self.view insertSubview:_tableView atIndex:0];
    
}

- (void)backViewController {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[MenuDetailsViewController new] animated:true];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
