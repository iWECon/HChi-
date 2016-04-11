//
//  MyZoneTableViewCell_Menu.m
//  HChi
//
//  Created by uniQue on 16/1/21.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "MyZoneTableViewCell.h"
#import "HCGlobalVariable.h"

@implementation MyZoneTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _menuImageView.layer.cornerRadius = 10;
    _menuImageView.layer.masksToBounds = true;
    _menuImageView.layer.borderColor = [UIColor grayColor].CGColor;
    _menuImageView.layer.borderWidth = 0.5;
    
    _menuTimeLabel.textColor = [UIColor whiteColor];
    _menuTitleLabel.textColor = _menuTimeLabel.textColor;
    
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    effectView.frame = CGRectMake(0, 0, ScreenSize.width, self.frame.size.height);
    [_menuBackGroundImageView addSubview:effectView];
    
    _menuImageView.contentMode = UIViewContentModeScaleAspectFill;
    _menuImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
