//
//  IssueViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/22.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "IssueViewCell.h"

@implementation IssueViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
}


- (void)configureCellWithDic:(NSDictionary *)dic withIndex:(NSIndexPath *)indexPath {
    NSString * stepText = dic[@"step"];
    self.stepLabel.text = stepText;
    
    NSString * title = dic[@"title"];
    self.titleLabel.text = title;
    
    NSString * tipsText = dic[@"tips"];
    self.tipsLabel.text = tipsText;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
