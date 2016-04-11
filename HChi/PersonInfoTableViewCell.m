//
//  PersonInfoTableViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/21.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "PersonInfoTableViewCell.h"
#import "HCGlobalVariable.h"

@interface PersonInfoTableViewCell ()

@property (nonatomic, strong) UIImageView * headImageView;

@end

@implementation PersonInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14 - 1];
        
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    }
    return self;
}

- (void)configureCellWithDic:(NSDictionary *)dic withIndexPath:(NSIndexPath *)indexPath {
    
    NSString *  title = dic[@"title"];
    self.textLabel.text = title;
    
    NSString * subTitle = dic[@"subTitle"];
    self.detailTextLabel.text = subTitle;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.detailTextLabel.text = nil;
            if (_headImageView == nil) {
                _headImageView = [[UIImageView alloc]  initWithFrame:CGRectMake(ScreenSize.width - 40 - 60, 80/2 - 30, 60, 60)];
                if ([personSettings[0][0][@"imagePath"]  isEqual: @""]) {
                    _headImageView.image = [UIImage imageNamed:@"userHeadImage"];
                } else {
                    _headImageView.image = [UIImage imageWithContentsOfFile:personSettings[0][0][@"imagePath"]];
                }
                _headImageView.layer.cornerRadius = 5;
                _headImageView.layer.masksToBounds = true;
                _headImageView.layer.borderWidth = 0.5;
                _headImageView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.3].CGColor;
                [self addSubview:_headImageView];
            }
        } else {
            if (_headImageView == nil) {
                [_headImageView removeFromSuperview];
                _headImageView = nil;
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
