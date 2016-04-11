//
//  MenuListTableViewCell.h
//  HChi
//
//  Created by uniQue on 16/1/18.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimateCollectionViewCell.h"

@interface MenuListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *useIng;


- (void)configureCellWithDic:(NSDictionary *)dic;

@end
