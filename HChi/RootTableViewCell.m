//
//  RootTableViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/22.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "RootTableViewCell.h"
#import "HCGlobalVariable.h"

@implementation RootTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.menuImageView.clipsToBounds = true;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2;
    self.userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImageView.layer.borderWidth = 1.0;
    self.userImageView.layer.masksToBounds = true;
}

- (void)configureCellWithDic:(NSDictionary *)dic withIndex:(NSIndexPath *)indexPath {
    
    NSString * title = dic[@"title"];
    self.titleLabel.text = title;
    
    NSString * img = dic[@"image"];
    self.menuImageView.image = [UIImage imageNamed:img];
    
    NSString * userid = dic[@"userID"];
    self.userLabel.text = userid;
    
    NSString * userImg = dic[@"userImage"];
    self.userImageView.image = [UIImage imageNamed:userImg];
    
    NSString * other = dic[@"other"];
    self.otherLabel.text = other;
}


- (void)cellShowsAnimate {
    CGRect rect = self.frame;
    CGRect recoverRect = rect;
    
    rect.origin = CGPointMake(rect.origin.x, rect.origin.y + self.frame.size.height * 2);
    
    self.alpha = 0.1;
    
    if (RootViewCellShowingAnimate) {
        self.frame = rect;
    } else {
        self.frame = recoverRect;
    }
    
    [UIView animateWithDuration:CellAnimateTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (rect.origin.y != recoverRect.origin.y) {
            self.frame = recoverRect;
        }
        self.alpha = 1;
    } completion:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
