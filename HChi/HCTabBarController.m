//
//  HCTabBarController.m
//  HChi
//
//  Created by uniQue on 16/1/13.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "HCTabBarController.h"
#import "CustomViewController.h"



@interface HCTabBarController ()<RemoveEffectViewProtocol>

@property (nonatomic, strong) IssueView * issueBackgroundView;
@end

@implementation HCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.hidden = true;
    CGRect tabBarFrame = self.tabBar.frame;
    tabBarFrame.origin.y = ScreenSize.height + 49;
    self.tabBar.frame = tabBarFrame;
    [self.view addSubview:HCNCTabBarView];
    
    [HCNCTabBarView.selectRootViewButton addTarget:self action:@selector(rootViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [HCNCTabBarView.selectIssueViewButton addTarget:self action:@selector(issueViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [HCNCTabBarView.selectPersonViewButton addTarget:self action:@selector(personViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

CGRect _loadRect;
CGRect _recoverLoadRect;
CGRect _productRect;
CGRect _recoverProductRect;

- (void)removeSelf {
    [self issueViewButtonAction];
}

- (void)issueViewButtonAction {
    
    if (HCNCTabBarView.selectIssueViewButton.selected == false) {
        HCNCTabBarView.selectIssueViewButton.selected = true;
    } else {
        HCNCTabBarView.selectIssueViewButton.selected = false;
    }
    
    if (!_issueBackgroundView) {
        _issueBackgroundView = [[IssueView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
        _issueBackgroundView.removeDelegate = self;
        [self.view addSubview:_issueBackgroundView];
        
        _loadRect = _issueBackgroundView.uploadMenuButton.frame;
        _recoverLoadRect = _loadRect;
        _loadRect.origin.y = ScreenSize.height;
        _loadRect.origin.x = ScreenSize.width/2/2 + ScreenSize.width/2/2/2;
        _loadRect.size = CGSizeMake(0, 0);
        _issueBackgroundView.uploadMenuButton.frame = _loadRect;
        [_issueBackgroundView.uploadMenuButton addTarget:self action:@selector(uploadMenuButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        _productRect = _issueBackgroundView.uploadProductButton.frame;
        _recoverProductRect = _productRect;
        _productRect.origin.y = ScreenSize.height;
        _productRect.origin.x = ScreenSize.width/2 + ScreenSize.width/2/2/2;
        _productRect.size = CGSizeMake(0, 0);
        _issueBackgroundView.uploadProductButton.frame = _productRect;
        [_issueBackgroundView.uploadProductButton addTarget:self action:@selector(uploadProductButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _issueBackgroundView.closeImageView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
        [UIView animateWithDuration:0.2 animations:^{
            _issueBackgroundView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _issueBackgroundView.uploadMenuButton.frame = _recoverLoadRect;
                _issueBackgroundView.uploadProductButton.frame = _recoverProductRect;
                
                _issueBackgroundView.closeImageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                _issueBackgroundView.closeImageView.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished) {}];
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            _issueBackgroundView.uploadMenuButton.frame = _loadRect;
            _issueBackgroundView.uploadProductButton.frame = _productRect;
            
            _issueBackgroundView.closeImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            _issueBackgroundView.closeImageView.transform = CGAffineTransformMakeRotation(M_PI/4);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _issueBackgroundView.alpha = 0;
            } completion:^(BOOL finished) {
                [_issueBackgroundView removeFromSuperview];
                _issueBackgroundView = nil;
            }];
        }];
    }
    
}


- (void)changeInterfaceWithIndex:(int)index {
    
    self.selectedIndex = index;
    
    if (index == 0) {
        HCNCTabBarView.selectRootViewButton.selected = true;
        HCNCTabBarView.selectRootViewLabel.textColor = HCColorForTheme;
        
        HCNCTabBarView.selectPersonViewButton.selected = false;
        HCNCTabBarView.selectPersonViewLabel.textColor = [UIColor blackColor];
    } else {
        HCNCTabBarView.selectRootViewButton.selected = false;
        HCNCTabBarView.selectRootViewLabel.textColor = [UIColor blackColor];
        
        HCNCTabBarView.selectPersonViewButton.selected = true;
        HCNCTabBarView.selectPersonViewLabel.textColor = HCColorForTheme;
    }
    
}

- (void)rootViewButtonAction {
    [self changeInterfaceWithIndex:0];
}

- (void)personViewButtonAction {
    [self changeInterfaceWithIndex:1];
}

- (void)uploadMenuButtonAction {
    [self removeSelf];
    UINavigationController * issueView = [[UINavigationController alloc] initWithRootViewController:[IssueViewController new]];
    [self presentViewController:issueView animated:true completion:nil];
}

- (void)uploadProductButtonAction {
    [self removeSelf];
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
