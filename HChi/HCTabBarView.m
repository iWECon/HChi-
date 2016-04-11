//
//  HCTabBarView.m
//  HChi
//
//  Created by uniQue on 16/1/13.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "HCTabBarView.h"
#import "HCGlobalVariable.h"

@interface HCTabBarView ()

@property (nonatomic, strong) UILabel * labelForRootView;
@property (nonatomic, strong) UILabel * labelForIssueView;
@property (nonatomic, strong) UILabel * labelForPersonView;

@end

@implementation HCTabBarView


CGSize tabBarIconSize;
CGPoint tabBarIconPoint;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        tabBarIconSize = CGSizeMake(40, 40);
        tabBarIconPoint = CGPointMake(0, -5);
        CGSize issueIconSize = CGSizeMake(80, 80);
        
        CGRect rootViewButtonRect = CGRectMake(ScreenSize.width / 2 - ScreenSize.width / 4 - tabBarIconSize.width / 2, tabBarIconPoint.y, tabBarIconSize.width, tabBarIconSize.height);
        CGRect issueViewButtonRect = CGRectMake(ScreenSize.width / 2 - issueIconSize.width / 2, - 30, issueIconSize.width, issueIconSize.height);
        CGRect personViewButtonRect = CGRectMake(ScreenSize.width / 2 + ScreenSize.width / 4 - tabBarIconSize.width / 2, tabBarIconPoint.y, tabBarIconSize.width, tabBarIconSize.height);
        
        // root View
        _selectRootViewButton = [[UIButton alloc] initWithFrame:rootViewButtonRect];
        [_selectRootViewButton setImage:[UIImage imageNamed:@"tabbar_1"] forState:UIControlStateNormal];
        [_selectRootViewButton setImage:[UIImage imageNamed:@"tabbar_1_HL"] forState:UIControlStateSelected];
        [_selectRootViewButton setImage:[UIImage imageNamed:@"tabbar_1_HL"] forState:UIControlStateHighlighted];
        _selectRootViewButton.selected = true;
        
        // issue View
        _selectIssueViewButton = [[UIButton alloc] initWithFrame:issueViewButtonRect];
        [_selectIssueViewButton setImage:[UIImage imageNamed:@"userHeadImage"] forState:UIControlStateNormal];
        [_selectIssueViewButton setImage:[UIImage imageNamed:@"userHeadImage"] forState:UIControlStateSelected];
        [_selectIssueViewButton setImage:[UIImage imageNamed:@"userHeadImage"] forState:UIControlStateHighlighted];
        
        // person View
        _selectPersonViewButton = [[UIButton alloc] initWithFrame:personViewButtonRect];
        [_selectPersonViewButton setImage:[UIImage imageNamed:@"tabbar_3"] forState:UIControlStateNormal];
        [_selectPersonViewButton setImage:[UIImage imageNamed:@"tabbar_3_HL"] forState:UIControlStateSelected];
        [_selectPersonViewButton setImage:[UIImage imageNamed:@"tabbar_3_HL"] forState:UIControlStateHighlighted];
        
        [self addSubview:_selectRootViewButton];
        [self addSubview:_selectIssueViewButton];
        [self addSubview:_selectPersonViewButton];
        
        // 主页标签
        _selectRootViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(rootViewButtonRect.origin.x + rootViewButtonRect.size.width/2 - 20, rootViewButtonRect.origin.y + rootViewButtonRect.size.height - 5, 40, 22)];
        [self setFontWithLabel:_selectRootViewLabel withTitle:@"有雅兴"];
        _selectRootViewLabel.textColor = [UIColor colorWithRed:0.4423 green:0.684 blue:1.0 alpha:1.0];
        [self addSubview:_selectRootViewLabel];
        
        // 个人标签
        _selectPersonViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(personViewButtonRect.origin.x + personViewButtonRect.size.width/2 - 20, rootViewButtonRect.origin.y + rootViewButtonRect.size.height - 5, 40, 22)];
        _selectPersonViewLabel.textColor = [UIColor blackColor];
        [self setFontWithLabel:_selectPersonViewLabel withTitle:@"个人"];
        [self addSubview:_selectPersonViewLabel];
        
    }
    return self;
}

- (void)setFontWithLabel:(UILabel *)label withTitle:(NSString *)title {
    label.font = [UIFont systemFontOfSize:10];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
