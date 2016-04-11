//
//  IssueNextViewController.m
//  HChi
//
//  Created by uniQue on 16/1/25.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "IssueNextViewController.h"
#import "IssueNextViewCell.h"
#import "HCGlobalVariable.h"
#import "IssueNextViewMoreCell.h"
#import "IssueNextViewPreviewCell.h"
#import "IssueNextViewAddImageCell.h"



static NSString * const IssueNextViewCellIdentifier = @"RootCell";


@interface IssueNextViewController ()<UITableViewDataSource, UITableViewDelegate, TextFieldSaveActionProtocol, TextFieldSaveActionProtocolOne>

@property (nonatomic, strong) UITableView * tableView;
//@property int numberOfRow;

@end

@implementation IssueNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    
    
    [self initView];
}

- (void)initView {
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveData)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if (_enterType == 0 || _enterType == 2) {
        
        [_tableView registerClass:[IssueNextViewCell class] forCellReuseIdentifier:IssueNextViewCellIdentifier];
        
    } else if (_enterType == 1 || _enterType == 3) {
        
        if (_enterType == 1) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加食材" style:UIBarButtonItemStyleDone target:self action:@selector(addFood)];
        } else {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加步骤" style:UIBarButtonItemStyleDone target:self action:@selector(addFood)];
        }
        
        [_tableView registerClass:[IssueNextViewMoreCell class] forCellReuseIdentifier:IssueNextViewCellIdentifier];
        
    } else {
        
        if (_enterType == 4) {
            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加图片" style:UIBarButtonItemStyleDone target:self action:@selector(addImage)];
            [_tableView registerClass:[IssueNextViewAddImageCell class] forCellReuseIdentifier:IssueNextViewCellIdentifier];
        } else {
            self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            return;
        }
        
        
    }
    
    [self.view addSubview:_tableView];
    
    
    if (_enterType == 0) {
        self.title = @"添加标题";
    } else if (_enterType == 1) {
        self.title = @"添加食材";
    } else if (_enterType == 2) {
        self.title = @"预估时间";
    } else if (_enterType == 3) {
        self.title = @"添加步骤";
    } else if (_enterType == 4) {
        self.title = @"添加图片";
    } else if (_enterType == 5) {
        self.title = @"预览";
    } else {
        self.title = @"发布成功";
    }
}

- (void)addImage {
    
}

- (void)addFood {
    if (_enterType == 1) {
        
        NSMutableArray * foods = publishedCookbook[1][0][@"food"];
        
        NSDictionary * dic = @{@"zhanweifu":@"请输入食材名称以及用量(g)",
                               @"content":@""};
        
        NSInteger index =[foods count];
        [foods insertObject:dic atIndex:index];
        
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else if (_enterType == 3) {
        
        NSMutableArray * step = publishedCookbook[3][0][@"steps"];
        NSDictionary * dic = @{@"zhanweifu":@"请输入详细步骤",
                               @"content":@""};
        NSInteger index =[step count];
        [step insertObject:dic atIndex:index];
        
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}


- (void)saveData {
    
    [self.navigationController popViewControllerAnimated:true];
    
}


- (void)issueNextViewMoreCell:(UITableViewCell *)cell textFieldSaveActionWithText:(NSString *)text{
    
    
    if (_enterType == 0) {
        [publishedCookbook[0][0] setValue:text forKey:@"title"];
        
    } else if (_enterType == 1) {
        
        [publishedCookbook[1][0] setValue:[NSString stringWithFormat:@"已添加 %d 味食材", (int)[publishedCookbook[1][0][@"food"] count]] forKey:@"title"];
        
    } else if (_enterType == 2) {
        
        [publishedCookbook[2][0] setValue:text forKey:@"title"];
    } else if (_enterType == 3) {
        
        [publishedCookbook[3][0] setValue:[NSString stringWithFormat:@"已添加 %d 个步骤", (int)[publishedCookbook[3][0][@"steps"] count]] forKey:@"title"];
    } else if (_enterType == 4) {
        
        [publishedCookbook[4][0] setValue:[NSString stringWithFormat:@"已添加 %d 张图片", (int)[publishedCookbook[3][0][@"images"] count]] forKey:@"title"];
    } else if (_enterType == 5) {
        
        
    } else {
        
        
    }
    [self saveData];
}


- (void)endEditingSaveContentWithCell:(UITableViewCell *)cell withContent:(NSString *)text {
    
    if (_enterType == 1) {
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        
        NSMutableArray * array = publishedCookbook[1][0][@"food"];
        
        NSMutableDictionary * dic = [array[indexPath.row] mutableCopy];
        
        dic[@"content"] = text;
        
        [array replaceObjectAtIndex:indexPath.row withObject:dic];
    }
    
    if (_enterType == 3) {
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        
        NSMutableArray * array = publishedCookbook[3][0][@"steps"];
        
        NSMutableDictionary * dic = [array[indexPath.row] mutableCopy];
        
        dic[@"content"] = text;
        
        [array replaceObjectAtIndex:indexPath.row withObject:dic];
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_enterType == 0 || _enterType == 2) {
        return 1;
    } else if (_enterType == 1 || _enterType == 3) {
        if (_enterType == 1) {
            return [publishedCookbook[1][0][@"food"] count];
        } else {
            return [publishedCookbook[3][0][@"steps"] count];
        }
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_enterType == 0 || _enterType == 2) {
        IssueNextViewCell * cell = [tableView dequeueReusableCellWithIdentifier:IssueNextViewCellIdentifier forIndexPath:indexPath];
        cell.textDelegate = self;
        
        NSString * title;
        if (_enterType == 0) {
            title = publishedCookbook[0][0][@"title"];
            if ([title  isEqual: @"标题"]) {
                cell.textField.placeholder = @"请输入菜谱名称";
            } else {
                cell.textField.placeholder = title;
            }
        } else {
            title = publishedCookbook[2][0][@"title"];
            if ([title  isEqual: @"时间"]) {
                cell.textField.placeholder = @"请输入预估时间";
            } else {
                cell.textField.placeholder = title;
            }
        }
        
        return cell;
    } else if (_enterType == 1 || _enterType == 3) {
        IssueNextViewMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:IssueNextViewCellIdentifier forIndexPath:indexPath];
        
        cell.textDelegate = self;
        
        if (_enterType == 1) {
            if ([publishedCookbook[1][0][@"food"] count] != 0) {
                NSDictionary * titles = publishedCookbook[1][0][@"food"][indexPath.row];
                
                if (![titles[@"content"]  isEqualToString: @""]) {
                    cell.textField.placeholder = titles[@"content"];
                } else {
                    cell.textField.placeholder = titles[@"zhanweifu"];
                }
            }
        } else {
            
            NSDictionary * steps = publishedCookbook[3][0][@"steps"][indexPath.row];
            
            if (![steps[@"content"]  isEqualToString: @""]) {
                cell.textField.placeholder = steps[@"content"];
            } else {
                cell.textField.placeholder = steps[@"zhanweifu"];
            }
        }
        
        return cell;
    } else {
        IssueNextViewPreviewCell * cell = [tableView dequeueReusableCellWithIdentifier:IssueNextViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_enterType == 1 || _enterType == 3) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 100)];
        [button setTitle:@"添加" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.backgroundColor = [UIColor redColor];
        return button;
    }
    return [UIView new];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_enterType == 4) {
        return 120;
    }
    return 44;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
