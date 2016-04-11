//
//  SettinsTableViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/21.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "SettinsTableViewCell.h"
#import "HCGlobalVariable.h"

@implementation SettinsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

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

- (void)configureCellWithDic:(NSDictionary *)dic {
    NSString * title = dic[@"title"];
    self.textLabel.text = title;
    
    NSString * subTitle = dic[@"subTitle"];
    self.detailTextLabel.text = subTitle;
    
    if ([title isEqualToString:@"主题颜色"]) {
        if ([self viewWithTag:999] == nil) {
            UIView * themeColor = [[UIView alloc] initWithFrame:CGRectMake(ScreenSize.width - 35 - 30, self.frame.size.height / 2 - 15, 30, 30)];
            themeColor.backgroundColor = HCColorForTheme;
            themeColor.layer.cornerRadius = 5;
            themeColor.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.7].CGColor;
            themeColor.layer.borderWidth = 0.5;
            themeColor.layer.masksToBounds = true;
            themeColor.tag = 999;
            [self addSubview:themeColor];
        } else {
            UIView * themeColor = (UIView *)[self viewWithTag:999];
            themeColor.backgroundColor = HCColorForTheme;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
