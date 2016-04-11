//
//  PersonInfoViewController.m
//  HChi
//
//  Created by uniQue on 16/1/18.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "HCGlobalVariable.h"
#import "TableViewDataSource.h"
#import "PersonInfoTableViewCell.h"
#import "ChangeInfoViewController.h"


static NSString * const PersonInfoCellIndentifier = @"InfoCell";

@interface PersonInfoViewController ()<UITableViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView * tableView;

//@property (nonatomic, strong) NSMutableArray * userData;

@property (nonatomic, strong) TableViewDataSource * personInfoDataSource;

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
    
    self.title = @"个人设置";
    
    [self initView];
}

- (void)initView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    TableViewCellConfigureBlock personInfoCellDataSourceBlock = ^(PersonInfoTableViewCell * infoCell, NSDictionary * dic, NSIndexPath * indexPath) {
        [infoCell configureCellWithDic:dic withIndexPath:indexPath];
    };
    
    self.personInfoDataSource = [[TableViewDataSource alloc] initWithItems:personSettings cellIdentifier:PersonInfoCellIndentifier cellBlock:personInfoCellDataSourceBlock];
    
    _tableView.delegate = self;
    _tableView.dataSource = self.personInfoDataSource;
    _tableView.tableFooterView = [UIView new];
    
    [_tableView registerClass:[PersonInfoTableViewCell class] forCellReuseIdentifier:PersonInfoCellIndentifier];
    
    [self.view addSubview:_tableView];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"本地相册", @"相机拍照", nil];
            [actionSheet showInView:self.view];
            
        } else {
            
            ChangeInfoViewController * nextVC = [ChangeInfoViewController new];
            nextVC.enterType = (int)indexPath.row;
            if (indexPath.row == 1) {
                nextVC.sender = personSettings[0][1][@"subTitle"];
            }
            if (indexPath.row == 3) {
                nextVC.sender = personSettings[0][3][@"subTitle"];
            }
            [self.navigationController pushViewController:nextVC animated:true];
            
            _isBack = false;
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"%ld", buttonIndex);
    NSUInteger sourceType = 0;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                NSLog(@"本地相册");
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 1:
                NSLog(@"相机");
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 2:
                sourceType = -1;
                break;
            default:
                sourceType = -1;
                break;
        }
    }
    
    if (sourceType == -1) {
        return;
    }
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = true;
    imagePickerController.sourceType = sourceType;
    [imagePickerController.navigationBar insertSubview:HCNCBackgroundForSubView atIndex:0];
    [imagePickerController.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self presentViewController:imagePickerController animated:true completion:nil];
}

#pragma mark- 保存图片至沙盒
- (void)saveImage:(UIImage *)cureentImage withName:(NSString *)imageName {
    NSData * imageData = UIImageJPEGRepresentation(cureentImage, 1);
    // 获取沙盒目录
    NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:false];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:true completion:nil];
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // 保存图片至本地， 上传到服务器需要使用
    [self saveImage:image withName:@"avatar.png"];
    
    NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    
    // 设置
    [personSettings[0][0] setValue:fullPath forKey:@"imagePath"];
    
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
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
