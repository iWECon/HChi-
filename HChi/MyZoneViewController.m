//
//  MyZoneViewController.m
//  HChi
//
//  Created by uniQue on 16/1/21.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "MyZoneViewController.h"
#import "CustomViewController.h"

@interface MyZoneViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * myZoneTableView;
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, strong) TableViewDataSource * tableViewDataSource;

@end

@implementation MyZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = _navTitle;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [HCNCBackgroundForSubView removeFromSuperview];
}

- (void)initView {
    
    _myZoneTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStylePlain];
    _myZoneTableView.tableFooterView = [UIView new];
    [self.view addSubview:_myZoneTableView];
    
    _myZoneTableView.delegate = self;
    _myZoneTableView.dataSource = self;
    _myZoneTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _myZoneTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myZoneTableView.separatorInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    
    [_myZoneTableView registerNib:[UINib nibWithNibName:@"MyZoneCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
    [_myZoneTableView registerNib:[UINib nibWithNibName:@"MyZoneCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
    [_myZoneTableView registerNib:[UINib nibWithNibName:@"MyZoneCell" bundle:nil] forCellReuseIdentifier:@"CollectionCell"];
    
    if (_selectType == 0 || _selectType == 1) {
        
        if (_selectType == 0) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStyleDone target:self action:@selector(presentUpLoadMenu)];
        } else {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStyleDone target:self action:@selector(presentUpLoadWroks)];
        }
        
    }
}

- (void)presentUpLoadMenu {
    UINavigationController * upload = [[UINavigationController alloc] initWithRootViewController:[IssueViewController new]];
    [self presentViewController:upload animated:true completion:nil];
}

- (void)presentUpLoadWroks {
//    UINavigationController * upload = [[UINavigationController alloc] initWithRootViewController:[IssueViewController new]];
//    [self presentViewController:upload animated:true completion:nil];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_selectType == 0 || _selectType == 2) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectType == 0) {
        MyZoneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
        
        cell.menuImageView.image = [UIImage imageNamed:@"caomei"];
        cell.menuBackGroundImageView.image = cell.menuImageView.image;
        cell.menuTitleLabel.text = @"面";
        cell.menuTimeLabel.text = @"上传时间：2016/01/21 12:40";
        
        return cell;
    } else if (_selectType == 1) {
        MyZoneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
        
        cell.menuImageView.image = [UIImage imageNamed:@"caomei"];
        cell.menuBackGroundImageView.image = cell.menuImageView.image;
        cell.menuTitleLabel.text = @"面";
        cell.menuTimeLabel.text = @"上传时间：2016/01/21 12:40";
        
        return cell;
    } else {
        MyZoneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell" forIndexPath:indexPath];
        
        cell.menuImageView.image = [UIImage imageNamed:@"caomei"];
        cell.menuBackGroundImageView.image = cell.menuImageView.image;
        cell.menuTitleLabel.text = @"面";
        cell.menuTimeLabel.text = @"上传时间：2016/01/21 12:40";
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
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
