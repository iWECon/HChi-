//
//  IssueNextViewMoreCell.m
//  HChi
//
//  Created by uniQue on 16/1/25.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "IssueNextViewMoreCell.h"
#import "HCGlobalVariable.h"

@interface IssueNextViewMoreCell ()<UITextFieldDelegate>

@end

@implementation IssueNextViewMoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 8, ScreenSize.width - 8*2, 30)];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.delegate = self;
        [self.contentView addSubview:_textField];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:UITextFieldTextDidEndEditingNotification object:nil];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (![textField.text  isEqualToString: @""]) {
        [_textDelegate issueNextViewMoreCell:self textFieldSaveActionWithText:textField.text];
    } else {
        [_textDelegate issueNextViewMoreCell:self textFieldSaveActionWithText:textField.placeholder];
    }
    
    return true;
}

- (void)notificationAction:(NSNotification *)noti {
    
    if (![_textField.text  isEqualToString: @""]) {
        [_textDelegate endEditingSaveContentWithCell:self withContent:_textField.text];
    } else {
        [_textDelegate endEditingSaveContentWithCell:self withContent:_textField.placeholder];
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
