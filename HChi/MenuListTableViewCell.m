//
//  MenuListTableViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/18.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "MenuListTableViewCell.h"

@implementation MenuListTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
}

- (void)configureCellWithDic:(NSDictionary *)dic {
    
    NSString * title = dic[@"title"];
    _nameLabel.text = title;
    
    NSString * imageName = dic[@"image"];
    _imgView.image = [UIImage imageNamed:imageName];
    
    NSString * time = dic[@"time"];
    _timeLabel.text = time;
    
    NSString * ing = dic[@"ing"];
    _useIng.text = ing;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
