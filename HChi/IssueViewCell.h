//
//  IssueViewCell.h
//  HChi
//
//  Created by uniQue on 16/1/22.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;


- (void)configureCellWithDic:(NSDictionary *)dic withIndex:(NSIndexPath *)indexPath;


@end
