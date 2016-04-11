//
//  IssueNextViewMoreCell.h
//  HChi
//
//  Created by uniQue on 16/1/25.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>


@class IssueNextViewMoreCell;

@protocol TextFieldSaveActionProtocolOne <NSObject>

- (void)issueNextViewMoreCell:(UITableViewCell *)cell textFieldSaveActionWithText:(NSString *)text;

- (void)endEditingSaveContentWithCell:(UITableViewCell *)cell withContent:(NSString *)text;

@end


@interface IssueNextViewMoreCell : UITableViewCell

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) id<TextFieldSaveActionProtocolOne> textDelegate;

@end
