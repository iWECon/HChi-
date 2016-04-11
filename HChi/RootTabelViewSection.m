//
//  RootTabelViewSection.m
//  HChi
//
//  Created by uniQue on 16/1/24.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "RootTabelViewSection.h"

@implementation RootTabelViewSection


- (IBAction)todayAction:(id)sender {
    
    [_tapDelegate tapGestureActionWithIndex:0];
}

- (IBAction)videoAction:(id)sender {
    
    [_tapDelegate tapGestureActionWithIndex:1];
}

- (IBAction)shakeAction:(id)sender {
    [_tapDelegate tapGestureActionWithIndex:3];
}

- (IBAction)collectionAction:(id)sender {
    
    [_tapDelegate tapGestureActionWithIndex:2];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
