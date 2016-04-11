//
//  BigPictureModeViewController.m
//  HChi
//
//  Created by uniQue on 16/1/27.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "BigPictureModeViewController.h"
#import "CustomViewController.h"

@interface BigPictureModeViewController ()


@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation BigPictureModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)initView {
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) collectionViewLayout:[UICollectionViewFlowLayout new]];
    
    [self.view addSubview:_collectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [HCNCBackgroundForSubView removeFromSuperview];
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
