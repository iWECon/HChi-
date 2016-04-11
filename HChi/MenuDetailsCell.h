//
//  MenuDetailsCell.h
//  HChi
//
//  Created by uniQue on 16/1/27.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuDetailsCell : UITableViewCell


- (void)configureCellWithArray:(NSArray *)array withIndex:(NSIndexPath *)indexPath;

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stepImageView;

@end
