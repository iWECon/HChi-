//
//  IssueViewController.m
//  HChi
//
//  Created by uniQue on 16/1/20.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "IssueViewController.h"
#import "HCGlobalVariable.h"
#import "TableViewDataSource.h"
#import "IssueViewCell.h"
#import "IssueNextViewController.h"


static NSString * const IssueViewCellIdentifier = @"StepCell";
@interface IssueViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UITableView * issueStepTableView;


@property (nonatomic, strong) TableViewDataSource * stepDataSource;
@property (nonatomic, strong) NSMutableArray * arrayData;

@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布菜谱";
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [_issueStepTableView reloadData];
    [self.navigationController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
}

- (void)backViewController {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (void)initView {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backViewController)];
    
    
    _issueStepTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStylePlain];
    _issueStepTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _issueStepTableView.tableFooterView = [UIView new];
    
    TableViewCellConfigureBlock stepDataSourceBlock = ^(IssueViewCell * issueCell, NSDictionary * dic, NSIndexPath * indexPath) {
        [issueCell configureCellWithDic:dic withIndex:indexPath];
    };
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"IssueMenu" ofType:@"plist"];
    publishedCookbook = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    self.stepDataSource = [[TableViewDataSource alloc] initWithItems:publishedCookbook cellIdentifier:IssueViewCellIdentifier cellBlock:stepDataSourceBlock];
    
    _issueStepTableView.delegate = self;
    _issueStepTableView.dataSource = self.stepDataSource;
    
    [_issueStepTableView registerNib:[UINib nibWithNibName:@"IssueViewCell" bundle:nil] forCellReuseIdentifier:IssueViewCellIdentifier];
    
    [self.view addSubview:_issueStepTableView];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    IssueNextViewController * inVC = [IssueNextViewController new];
    inVC.enterType = (int)indexPath.section;
    [self.navigationController pushViewController:inVC animated:true];
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
