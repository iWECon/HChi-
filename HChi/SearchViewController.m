//
//  SearchViewController.m
//  HChi
//
//  Created by uniQue on 16/1/20.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "SearchViewController.h"
#import "HCGlobalVariable.h"

@interface SearchViewController ()<UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
    [self initView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [HCNCBackgroundForSubView removeFromSuperview];
}

- (void)initView {
    
#pragma mark 创建搜索框
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 44/2 + 20 - 17, ScreenSize.width - 35, 34)];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.placeholder = @"搜索";
    searchBar.showsCancelButton = true;
    searchBar.delegate = self;
    [searchBar becomeFirstResponder];
    self.navigationItem.titleView = searchBar;
    
#pragma mark UILabel 添加热门搜索
//    UILabel * hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64 + 20, ScreenSize.width, 34)];
//    hotLabel.text = @"热门搜索";
//    hotLabel.font = [UIFont systemFontOfSize:HCThemeFontSize - 2];
//    [self.view insertSubview:hotLabel atIndex:0];
    
    
#pragma mark UILabel 添加热门搜索内容
    UIView * hotView = [[NSBundle mainBundle] loadNibNamed:@"HotSearchView" owner:self options:nil].firstObject;
    hotView.frame = CGRectMake(0, 64, ScreenSize.width, ScreenSize.height);
    [self.view addSubview:hotView];
}

- (void)backViewController {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self backViewController];
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
