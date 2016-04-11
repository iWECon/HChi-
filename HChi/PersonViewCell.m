//
//  PersonViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/12.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "PersonViewCell.h"
#import "HCGlobalVariable.h"

@implementation PersonViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    }
    return self;
}

- (void)configureCellWithDic:(NSDictionary *)dic withIndex:(NSIndexPath *)indexPath {
    self.textLabel.font = [UIFont systemFontOfSize:14];
    NSString * title = dic[@"title"];
    self.textLabel.text = title;
    if ([title isEqualToString:@"退出"]) {
        self.textLabel.textColor = [UIColor redColor];
    } else {
        self.textLabel.textColor = [UIColor blackColor];
    }
    
    NSString * subTitle = dic[@"subTitle"];
    self.detailTextLabel.text = subTitle;
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        NSString * imageName = dic[@"iconName"];
        self.imageView.image = [UIImage imageNamed:imageName];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
