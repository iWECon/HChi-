//
//  AnimateCollectionViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/19.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "AnimateCollectionViewCell.h"
#import "HCGlobalVariable.h"


@implementation AnimateCollectionViewCell

CGRect _rootViewCellRecoverRect;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)rootViewCellShowAnimate {
    CGRect rect = self.frame;
    _rootViewCellRecoverRect = rect;
    rect.origin = CGPointMake(rect.origin.x, rect.origin.y + 200);
    rect.size.height = _rootViewCellRecoverRect.size.height / 2;
    self.alpha = 0.1;
    
    if (RootViewCellShowingAnimate) {
        self.frame = rect;
    } else {
        self.frame = _rootViewCellRecoverRect;
    }
    
    [UIView animateWithDuration:CellAnimateTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (rect.origin.y != _rootViewCellRecoverRect.origin.y) {
            self.frame = _rootViewCellRecoverRect;
        }
        self.alpha = 1;
    } completion:nil];
    
}


@end
