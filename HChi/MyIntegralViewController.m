//
//  MyIntegralViewController.m
//  HChi
//
//  Created by uniQue on 16/1/20.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "MyIntegralViewController.h"
#import "HCGlobalVariable.h"

@interface MyIntegralViewController ()

@end

@implementation MyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    HCShowTabBarView(true);
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
