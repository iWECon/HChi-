//
//  RootTabelViewSection.h
//  HChi
//
//  Created by uniQue on 16/1/24.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TapGestureProtocol <NSObject>

- (void)tapGestureActionWithIndex:(int)index;

@end

@interface RootTabelViewSection : UIView

@property (nonatomic, strong) id<TapGestureProtocol> tapDelegate;


@end
