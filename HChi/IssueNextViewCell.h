//
//  IssueNextViewCell.h
//  HChi
//
//  Created by uniQue on 16/1/25.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IssueNextViewCell;

@protocol TextFieldSaveActionProtocol <NSObject>

- (void)issueNextViewMoreCell:(UITableViewCell *)cell textFieldSaveActionWithText:(NSString *)text;

@end



@interface IssueNextViewCell : UITableViewCell

@property (nonatomic, strong) id<TextFieldSaveActionProtocol> textDelegate;
@property int type;
@property (nonatomic, strong) UITextField * textField;

@end
