//
//  PersonViewCell.h
//  HChi
//
//  Created by uniQue on 16/1/12.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonViewCell : UITableViewCell

- (void)configureCellWithDic:(NSDictionary *)dic withIndex:(NSIndexPath *)indexPath;

@end
