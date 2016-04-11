//
//  SettingsContentsViewController.m
//  HChi
//
//  Created by uniQue on 16/1/21.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "SettingsContentsViewController.h"
#import "HCGlobalVariable.h"
#import "SettingsContentsTableViewCell.h"

@interface SettingsContentsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property NSString * saveValue;
@property (nonatomic, strong) UILabel * label;

@end

@implementation SettingsContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _navTitle;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveConfigure)];
    [self initView];
}

- (void)saveConfigure {
    NSLog(@"保存成功");
    if (_chooseType == 0) {
        [personAppSettings[0][_chooseType] setValue:_saveValue forKey:@"subTitle"];
        int saveFontSize = 14;
        if ([_saveValue  isEqual: @"超大"]) {
            saveFontSize = 20;
        } else if ([_saveValue  isEqual: @"较大"]) {
            saveFontSize = 16;
        } else if ([_saveValue  isEqual: @"正常"]) {
            saveFontSize = 14;
        } else {
            saveFontSize = 12;
        }
        HCThemeFontSize = saveFontSize;
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

- (void)initView {
    _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[SettingsContentsTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [personAppSettings[0][_chooseType][@"subItem"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsContentsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString * title = personAppSettings[0][_chooseType][@"subItem"][indexPath.row][@"title"];
    cell.textLabel.text = title;
    
    NSString * subTitle = personAppSettings[0][_chooseType][@"subItem"][indexPath.row][@"subTitle"];
    cell.detailTextLabel.text = subTitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsContentsTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    _saveValue = cell.textLabel.text;
    _label.font = [UIFont systemFontOfSize:[cell.detailTextLabel.text intValue]];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_chooseType == 0) {
        UIView * lgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 120)];
        _label = [[UILabel alloc] initWithFrame:lgView.bounds];
        _label.text = @"给懂生活的你";
        _label.font = [UIFont systemFontOfSize:HCThemeFontSize];
        _label.textAlignment = NSTextAlignmentCenter;
        [lgView addSubview:_label];
        return lgView;
    }
    return [UIView new];
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
