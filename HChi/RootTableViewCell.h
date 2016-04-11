//
//  RootTableViewCell.h
//  HChi
//
//  Created by uniQue on 16/1/22.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;


- (void)configureCellWithDic:(NSDictionary *)dic withIndex:(NSIndexPath *)indexPath;

- (void)cellShowsAnimate;

@end
