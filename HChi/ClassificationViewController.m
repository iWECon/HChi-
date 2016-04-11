//
//  ClassificationViewController.m
//  HChi
//
//  Created by uniQue on 16/1/14.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "ClassificationViewController.h"
#import "CustomViewController.h"

static NSString * const ClassificationTableViewCellIdentifier = @"ClassificationTableViewCell";
static NSString * const ClassificationCollectionViewCellIdentifier = @"ClassificationCollectionViewCell";

@interface ClassificationViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UITableView * classificationTableView;
@property (nonatomic, strong) UICollectionView * classificationCollectionView;
@property (nonatomic, strong) TableViewDataSource * cTableViewDataSource;

@end

@implementation ClassificationViewController

NSArray * _collectionViewCellDataArray;
/// 用于判断tableView向上还是向下滑动
CGFloat _classificationViewOldOffset = 0;

UIButton * _backButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
    
    _collectionViewCellDataArray = [NSArray new];
    
#pragma mark 创建navView中的内容 返回按钮
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backViewController)];
    
#pragma mark 创建搜索框
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
#pragma mark 创建tableView
    CGRect cTableViewRect = CGRectMake(0, 64, ScreenSize.width / 4, ScreenSize.height);
    _classificationTableView = [[UITableView alloc] initWithFrame:cTableViewRect style:UITableViewStylePlain];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Classification" ofType:@"plist"];
    _cellConfigureData = [[NSArray alloc] initWithContentsOfFile:path];
    
    _classificationTableView.tableFooterView = [UIView new];
    _classificationTableView.delegate = self;
    _classificationTableView.dataSource = self;
    _classificationTableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    _classificationTableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [_classificationTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:true scrollPosition:UITableViewScrollPositionNone];
    if (_viewDidLoadEnter == false) {
        [self reloadCollectionView:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    [_classificationTableView registerClass:[ClassificationTableViewCell class] forCellReuseIdentifier:ClassificationTableViewCellIdentifier];
    [self.view insertSubview:_classificationTableView atIndex:0];
    
#pragma mark 创建CollectionView
    _classificationCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(ScreenSize.width/4, 0, ScreenSize.width/4*3, ScreenSize.height) collectionViewLayout:[UICollectionViewFlowLayout new]];
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    _classificationCollectionView.collectionViewLayout = layout;
    
    _classificationCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _classificationCollectionView.delegate = self;
    _classificationCollectionView.dataSource = self;
    _classificationCollectionView.showsVerticalScrollIndicator = false;
    _classificationCollectionView.alwaysBounceVertical = true;
    _classificationCollectionView.contentInset = UIEdgeInsetsMake(0, 10, 10, 10);
    
    [_classificationCollectionView registerClass:[ClassificationCollectionViewCell class] forCellWithReuseIdentifier:ClassificationCollectionViewCellIdentifier];
    [self.view insertSubview:_classificationCollectionView atIndex:0];
    
}


- (void)backViewController {
    HCShowTabBarView(true);
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    UINavigationController * searchVC = [[UINavigationController alloc] initWithRootViewController:[SearchViewController new]];
    [self.navigationController presentViewController:searchVC animated:false completion:nil];
    return false;
}


- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return false;
}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigureData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassificationTableViewCell*  cell = [tableView dequeueReusableCellWithIdentifier:ClassificationTableViewCellIdentifier];
    NSArray * array = _cellConfigureData[indexPath.row];
    NSDictionary * dic = array[0];
    [cell configureCellTitleWithDic:dic];
    return cell;
}

#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self reloadCollectionView:indexPath];
}

- (void) reloadCollectionView:(NSIndexPath *)indexPath {
    NSArray * array = _cellConfigureData[indexPath.row];
    NSArray * dataArray = array[1];
    _collectionViewCellDataArray = dataArray;
    [_classificationCollectionView reloadData];
    
    [_classificationTableView selectRowAtIndexPath:indexPath animated:true scrollPosition:UITableViewScrollPositionBottom];
}

#pragma mark- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectionViewCellDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassificationCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassificationCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = _collectionViewCellDataArray[indexPath.row];
    
    [cell classificationVieCellShowAnimate];
    
    return cell;
}

#pragma mark- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
    ClassificationCollectionViewCell * cell = (ClassificationCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    MenuListViewController * mlVC = [MenuListViewController new];
    mlVC.navTitleText = cell.textLabel.text;
    
    [self.navigationController pushViewController:mlVC animated:true];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * fontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    NSString * text = _collectionViewCellDataArray[indexPath.row];
    CGSize textSize = [text sizeWithAttributes:fontAttributes];
    return CGSizeMake(textSize.width + 10, 44);
}

#pragma mark 边滚动边触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = _classificationCollectionView.contentOffset.y;
    
    if (y > _classificationViewOldOffset && y > 0) {
        ClassificationViewCellShowAnimate = true;
    } else {
        ClassificationViewCellShowAnimate = false;
    }
    _classificationViewOldOffset = y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
