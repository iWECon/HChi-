//
//  RootViewController.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "RootViewController.h"
#import "CustomViewController.h"


static NSString * const RootViewCellIdentifier = @"RootCell";


@interface RootViewController ()<UITableViewDelegate, UIScrollViewDelegate, UISearchBarDelegate, UISearchControllerDelegate, TapGestureProtocol>

@property (nonatomic, strong) TableViewDataSource * rootViewCellDataSource;
@property NSMutableArray * imageArray;
@property NSMutableArray * rootCellDataArray;
@property (nonatomic, strong) UISearchController * searchController;
@property (nonatomic, strong) TableViewDataSource * tableViewDataSource;

@property (nonatomic, strong) RootTabelViewSection * classificationView;

@end

@implementation RootViewController


/// 每日推荐 scroll View
UIScrollView * _dailyRecommendScrollView;
/// scrollView 的位置信息
CGRect _scrollViewRect;
/// scrollView 的内容: UIImageView
NSMutableArray * _dailyRecommendScrollViewContents;
// page control
UIPageControl * _pageControl;
// page control rect
CGRect _pageControlRect;
/// scrollView 当前显示的Image
UIImageView * _cureentImage;
/// 搜索框
UISearchBar * _searchBar;
/// 搜索框位置信息
CGRect _searchBarRect;
/// 用于判断tableView向上还是向下滑动
CGFloat _rootViewOldOffset = 0;
/// 分类View
CGRect classificationViewRect;


#pragma mark 初始化 init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"有雅兴";
    }
    return self;
}

#pragma mark 加载完毕 View did load
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * paths = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:nil];
    _imageArray = [[NSMutableArray alloc] initWithArray:paths];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self initView];
}

- (void)viewDidAppear:(BOOL)animated {
    HCShowTabBarView(true);
    
    if (_rootTableView.contentOffset.y > 64) {
        [self.navigationController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
        [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    } else {
        [self.navigationController.navigationBar.layer insertSublayer:HCNCBackgroundForRootView atIndex:0];
        [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = YES;
    [HCNCBackgroundForRootView removeFromSuperlayer];
}

#pragma mark 初始化视图: 给视图添加内容
- (void)initView {
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"RootView" ofType:@"plist"];
    _rootCellDataArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    _dailyRecommendScrollViewContents = [NSMutableArray new];
    
    _scrollViewRect = CGRectMake(0, 0, ScreenSize.width, 280);
    
    
    classificationViewRect = CGRectMake(0, _scrollViewRect.size.height + 10, ScreenSize.width, 80);
    
    _classificationView = (RootTabelViewSection *)[[NSBundle mainBundle] loadNibNamed:@"RootSectionHeadView" owner:self options:nil].firstObject;
    _classificationView.tapDelegate = self;
    
    [self createTableView];
    
    [self createScrollView];
    
    [self createPageControl];
    
    [self createSearchBar];
}

/// root table view
- (void)createTableView {
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStyleGrouped];
    
    TableViewCellConfigureBlock cellConfigureBlock = ^(RootTableViewCell * rootCell, NSDictionary * dic, NSIndexPath * indexPath) {
        [rootCell configureCellWithDic:dic withIndex:indexPath];
        [rootCell cellShowsAnimate];
    };
    
    self.tableViewDataSource = [[TableViewDataSource alloc] initWithItems:_rootCellDataArray cellIdentifier:RootViewCellIdentifier cellBlock:cellConfigureBlock];
    
    _rootTableView.delegate = self;
    _rootTableView.dataSource = self.tableViewDataSource;
    _rootTableView.tableFooterView = [UIView new];
    
    _rootTableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    _rootTableView.showsVerticalScrollIndicator = false;
    
    [_rootTableView registerNib:[UINib nibWithNibName:@"RootViewCell" bundle:nil] forCellReuseIdentifier:RootViewCellIdentifier];
    
    [self.view addSubview:_rootTableView];
}



/// 每日推荐
- (void)createScrollView {
    _dailyRecommendScrollView = [[UIScrollView alloc] initWithFrame:_scrollViewRect];
    _dailyRecommendScrollView.contentSize = CGSizeMake(ScreenSize.width * _imageArray.count, _scrollViewRect.size.height);
    _dailyRecommendScrollView.pagingEnabled = true;
    _dailyRecommendScrollView.bounces = false;
    _dailyRecommendScrollView.showsHorizontalScrollIndicator = false;
    _dailyRecommendScrollView.delegate = self;
    
    int  imageNumber = 0;
    for (int i = 0; i<_imageArray.count; i++) {
        UIImage * image = [UIImage imageWithContentsOfFile:_imageArray[i]];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(ScreenSize.width * imageNumber, 0, ScreenSize.width, _scrollViewRect.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = true;
        [_dailyRecommendScrollView addSubview:imageView];
        [_dailyRecommendScrollViewContents addObject:imageView];
        imageNumber ++;
    }
    
    [self.view addSubview:_dailyRecommendScrollView];
    
    _dailyRecommendScrollView.contentOffset = CGPointMake(ScreenSize.width, 0);
    
    [_dailyRecommendScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpVC)]];
}

- (void)jumpVC {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    HCShowTabBarView(false);
    [self.navigationController pushViewController:[MenuDetailsViewController new] animated:true];
}


/// 搜索框
- (void)createSearchBar {
    CGSize searchBarSize = CGSizeMake(ScreenSize.width - 40, 40);
    _searchBarRect = CGRectMake((ScreenSize.width - searchBarSize.width) / 2, _scrollViewRect.size.height - searchBarSize.height - 10, searchBarSize.width, searchBarSize.height);
    _searchBar = [[UISearchBar alloc] initWithFrame:_searchBarRect];
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.translucent = false;
    _searchBar.barTintColor = HCColorForTheme;
    _searchBar.delegate = self;
    
    // 遍历searchBar 中的子视图
    for (UIView * subview in [[_searchBar.subviews lastObject] subviews]) {
        // 找到子视图中的 UITextField
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField * textField = (UITextField *)subview;
            textField.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索菜谱、食材、季节等" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
        }
    }
    [self.view addSubview:_searchBar];
}


/// page control
- (void)createPageControl {
    
    _pageControlRect = CGRectMake(0, _dailyRecommendScrollView.frame.size.height - 15, ScreenSize.width, 15);
    _pageControl = [[UIPageControl alloc] initWithFrame:_pageControlRect];
    _pageControl.numberOfPages = _dailyRecommendScrollViewContents.count - 2;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    [self.view addSubview:_pageControl];
    
}

#pragma 跳转到搜索or分类页面
- (void)classification {
    HCShowTabBarView(false);
    
    [self.navigationController pushViewController:[ClassificationViewController new] animated:true];
}


#pragma mark- TapGestureProtocol
- (void)tapGestureActionWithIndex:(int)index {
    
    HCShowTabBarView(false);
    
    if (index == 0 || index == 1) {
        
        MenuListViewController * menuListVC = [MenuListViewController new];
        if (index == 0) {
            menuListVC.navTitleText = @"今日佳作";
        } else {
            menuListVC.navTitleText = @"美食视频";
        }
        [self.navigationController pushViewController:menuListVC animated:true];
        
    } else {
        
        if (index == 2) {
            [self.navigationController pushViewController:[ClassificationViewController new] animated:true];
        } else {
            MenuListViewController * menuListVC = [MenuListViewController new];
            menuListVC.navTitleText = @"摇一摇";
            [self.navigationController pushViewController:menuListVC animated:true];
        }
        
    }
}

#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self jumpVC];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return _scrollViewRect.size.height + classificationViewRect.size.height + 40;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return _classificationView;
    }
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}


#pragma mark- UIScrollViewDelegate
#pragma mark 滚动停止后触发
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int cureentPage = (int)(_dailyRecommendScrollView.contentOffset.x / ScreenSize.width) - 1;
    
    if (cureentPage == 3) {
        
        _dailyRecommendScrollView.contentOffset = CGPointMake(ScreenSize.width, 0);
        cureentPage = 0;
        _pageControl.currentPage = cureentPage;
        
    } else if (cureentPage == -1) {
        
        _dailyRecommendScrollView.contentOffset = CGPointMake(ScreenSize.width * (_dailyRecommendScrollViewContents.count - 2), 0);
        cureentPage = 2;
        _pageControl.currentPage = cureentPage;
        
    } else {
        
        _pageControl.currentPage = cureentPage;
        
    }
    
    _cureentImage = [self backScrollViewContent:cureentPage];
    
}

#pragma mark 边滚动边触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    // 改变位置信息
    [self resetHeadViewFrame:y];
}

- (UIImageView *)backScrollViewContent:(int)index {
    if (index == 0) {
        return _dailyRecommendScrollViewContents[1];
    } else if (index == 1) {
        return _dailyRecommendScrollViewContents[2];
    } else {
        return _dailyRecommendScrollViewContents[3];
    }
}

#pragma mark 滑动时改变位置信息
- (void)resetHeadViewFrame:(CGFloat)y {
    
    if (_cureentImage == nil) {
        _cureentImage = [self backScrollViewContent:0];
    }
    CGRect frame = _dailyRecommendScrollView.frame;
    CGRect cureentImageFrame = _cureentImage.frame;
    CGRect searchBarFrame = _searchBar.frame;
    CGRect pageControlFrame = _pageControl.frame;
    if (y < 0) {
        frame.origin.y = 0;
        frame.size.height = _scrollViewRect.size.height - y;
        _dailyRecommendScrollView.frame = frame;
        
        cureentImageFrame.origin.y = 0;
        cureentImageFrame.size.height = frame.size.height;
        _cureentImage.frame = cureentImageFrame;
        
        searchBarFrame.origin.y = _searchBarRect.origin.y + -y;
        _searchBar.frame = searchBarFrame;
        
        pageControlFrame.origin.y = _dailyRecommendScrollView.frame.size.height - 15;
        _pageControl.frame = pageControlFrame;
        
    } else if (y > _scrollViewRect.size.height - 64) {
        
        frame.origin.y += -y;
        _dailyRecommendScrollView.frame = frame;
        
        searchBarFrame.origin.y = _searchBarRect.origin.y + -y;
        _searchBar.frame = searchBarFrame;
        
        pageControlFrame.origin.y = _pageControlRect.origin.y + -y;
        _pageControl.frame = pageControlFrame;
        
        if (HCNCBackgroundForRootView.hidden == false) {
            HCNCBackgroundForRootView.hidden = true;
            
            [self.navigationController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
            
#pragma mark 设置导航栏右边的按钮为分类按钮
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"root_search"] style:UIBarButtonItemStyleDone target:self action:@selector(classification)];
        }
        
        if ([self.navigationController.navigationBar barStyle] == UIBarStyleBlack) {
            [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
        }
        
    } else {
        
        frame.origin.y = -y;
        _dailyRecommendScrollView.frame = frame;
        
        searchBarFrame.origin.y = _searchBarRect.origin.y + -y;
        _searchBar.frame = searchBarFrame;
        
        pageControlFrame.origin.y = _pageControlRect.origin.y + -y;
        _pageControl.frame = pageControlFrame;
        
        if (HCNCBackgroundForRootView.hidden == true) {
            HCNCBackgroundForRootView.hidden = false;
            
            [HCNCBackgroundForSubView removeFromSuperview];
            
#pragma mark 移除分类按钮
            self.navigationItem.rightBarButtonItem = [UIBarButtonItem new];
        }
        
        if ([self.navigationController.navigationBar barStyle] == UIBarStyleDefault) {
            [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
        }
    }
    
    if (y > _rootViewOldOffset && y > 0) {
        RootViewCellShowingAnimate = true;
    } else {
        RootViewCellShowingAnimate = false;
    }
    
    _rootViewOldOffset = y;
}


#pragma mark UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self presentSearchView];
    return false;
}

- (void)presentSearchView {
    HCShowTabBarView(false);
    UINavigationController * searchVC = [[UINavigationController alloc] initWithRootViewController:[SearchViewController new]];
    [self.navigationController presentViewController:searchVC animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
