//
//  IssueNextViewAddImageCell.m
//  HChi
//
//  Created by uniQue on 16/1/26.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "IssueNextViewAddImageCell.h"

@implementation IssueNextViewAddImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _foodImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _foodImage.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        [self.contentView addSubview:_foodImage];
//        
//        _addImg = [[UILabel alloc] initWithFrame:self.bounds];
//        _addImg.font = [UIFont boldSystemFontOfSize:36];
//        _addImg.text = @"+";
//        _addImg.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:_addImg];
//        
//        
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    self.foodImage.frame = self.bounds;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"frame"];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
