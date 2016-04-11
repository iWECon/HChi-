//
//  SettingsViewController.m
//  HChi
//
//  Created by uniQue on 16/1/21.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "SettingsViewController.h"
#import "HCGlobalVariable.h"
#import "SettinsTableViewCell.h"
#import "TableViewDataSource.h"
#import "SettingsContentsViewController.h"



static NSString * const CellIdentifier = @"SettingsCell";
@interface SettingsViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) TableViewDataSource * tableViewDataSource;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
    
    self.navigationItem.title = @"设置";
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [_tableView reloadData];
}

- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStyleGrouped];
    
    TableViewCellConfigureBlock cellConfigureBlock = ^(SettinsTableViewCell * settingsCell, NSDictionary * dic, NSIndexPath * indexPath) {
        [settingsCell configureCellWithDic:dic];
    };
    
    self.tableViewDataSource = [[TableViewDataSource alloc] initWithItems:personAppSettings cellIdentifier:CellIdentifier cellBlock:cellConfigureBlock];
    
    _tableView.delegate = self;
    _tableView.dataSource = self.tableViewDataSource;
    _tableView.tableFooterView = [UIView new];
    
    [_tableView registerClass:[SettinsTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:_tableView];
}

// did select row at index path
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            
            SettinsTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            SettingsContentsViewController * nextVC = [SettingsContentsViewController new];
            nextVC.chooseType = (int)indexPath.row;
            nextVC.navTitle = cell.textLabel.text;
            nextVC.dataArray = personAppSettings;
            [self.navigationController pushViewController:nextVC animated:true];
        } else {
            
        }
    }
}

// 返回节头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

// 返回节尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
