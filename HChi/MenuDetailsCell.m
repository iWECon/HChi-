//
//  MenuDetailsCell.m
//  HChi
//
//  Created by uniQue on 16/1/27.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "MenuDetailsCell.h"
#import "CustomViewController.h"

@implementation MenuDetailsCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentLabel.font = [UIFont systemFontOfSize:HCThemeFontSize];
    
    self.stepImageView.layer.cornerRadius = 10;
    self.stepImageView.layer.masksToBounds = true;
    
    [_contentLabel addObserver:self forKeyPath:@"text" options:0x01 | 0x02 context:nil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSString * content = change[@"new"];
    
    //计算内容大小
    CGSize size = [content boundingRectWithSize:CGSizeMake(311, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:HCThemeFontSize]} context:nil].size;
    
    //设置label高度
    CGRect contentLabelRect = _contentLabel.frame;
    contentLabelRect.size.height = size.height;
    _contentLabel.frame = contentLabelRect;
    
    // 拿到imgae高度
    float imgHeight = _stepImageView.frame.size.height;
    
    // 设置cell高度
    float emdHeight = _contentLabel.frame.origin.y + size.height + 23 + imgHeight + 20;
    CGRect rect = self.frame;
    rect.size.height = emdHeight;
    self.frame = rect;
}


- (void)dealloc {
    [_contentLabel removeObserver:self forKeyPath:@"text"];
}



- (void)configureCellWithArray:(NSArray *)array withIndex:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        self.textLabel.text = array[indexPath.row];
        self.detailTextLabel.text = @"";
        
        
    } else if (indexPath.section == 1) {
        
        
        NSDictionary * dic = array[indexPath.row];
        self.textLabel.text = dic[@"title"];
        self.detailTextLabel.text = dic[@"subtitle"];
        
        
    } else if (indexPath.section == 2) {
        
        // 做法
        _indexLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
        
        NSDictionary * dic = array[indexPath.row];
        _contentLabel.text = dic[@"content"];
        
        _stepImageView.image = [UIImage imageNamed:dic[@"image"]];
        
    } else {
        self.textLabel.text = array[indexPath.row];
        self.detailTextLabel.text = @"";
    }
}


@end
