//
//  ChangeInfoViewController.m
//  HChi
//
//  Created by uniQue on 16/1/21.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "ChangeInfoViewController.h"
#import "HCGlobalVariable.h"
#import "ChangeInfoTableViewCell.h"

@interface ChangeInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * changeInfoTableView;

@end

@implementation ChangeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)initView {
    _changeInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStyleGrouped];
    [self.view addSubview:_changeInfoTableView];
    
    _changeInfoTableView.delegate = self;
    _changeInfoTableView.dataSource = self;
    _changeInfoTableView.tableFooterView = [UIView new];
    
    [_changeInfoTableView registerNib:[UINib nibWithNibName:@"ChangeViewCell" bundle:nil] forCellReuseIdentifier:@"CellID"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_enterType == 2) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChangeInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    if (_enterType == 1) {
        cell.textView.hidden = true;
        cell.textField.hidden = false;
        
        cell.textField.placeholder = (NSString *)_sender;
    }
    
    
    if (_enterType == 2) {
        
        cell.textView.hidden = true;
        cell.textField.hidden = true;
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"男";
        } else {
            cell.textLabel.text = @"女";
        }
    }
    
    
    if (_enterType == 3) {
        cell.textView.hidden = false;
        cell.textField.hidden = true;
        
        cell.textView.text = (NSString *)_sender;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_enterType == 3) {
        return 80;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
