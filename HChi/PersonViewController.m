//
//  PersonViewController.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "PersonViewController.h"
#import "HCGlobalVariable.h"
#import "TableViewDataSource.h"
#import "PersonViewCell.h"
#import "PersonInfoViewController.h"
#import "MyZoneViewController.h"
#import "SettingsViewController.h"

static NSString * const PersonViewCellIdentifier = @"PersonCell";

@interface PersonViewController ()<UITableViewDelegate>

@property (nonatomic, strong) TableViewDataSource * personViewCellDataSource;
@property NSArray * personViewCellDataArray;

@end


@implementation PersonViewController

CGRect headViewRect;
/// 头部视图
UIView * headView;
/// 模糊背景图
UIImageView * imageView;
/// 模糊效果
UIVisualEffectView * effectView;
/// 用户头像
UIImageView * userHeadImage;
/// 用户昵称
UILabel * userNickName;
/// 个人签名
UILabel * userSign;

#pragma mark 初始化 init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"个人";
    }
    return self;
}

#pragma mark 加载完毕 View did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self initView];
    [self createHeadView];
}

#pragma mark 视图将要出现 view will appear
- (void)viewWillAppear:(BOOL)animated {
    HCShowTabBarView(true);
    [HCNCBackgroundForSubView removeFromSuperview];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    if ([personSettings[0][0][@"imagePath"]  isEqual: @""]) {
        userHeadImage.image = [UIImage imageNamed:@"userHeadImage"];
    } else {
        userHeadImage.image = [UIImage imageWithContentsOfFile:personSettings[0][0][@"imagePath"]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    self.hidesBottomBarWhenPushed=YES;
}

#pragma mark 创建头部视图
- (void)createHeadView {
    headViewRect = CGRectMake(0, 0, ScreenSize.width, 240);
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"];
    NSArray * userDataArray = [[NSArray alloc] initWithContentsOfFile:path];
    headView = [[UIView alloc] initWithFrame:headViewRect];
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:userDataArray[0][0][@"subTitle"]]];
    imageView.frame = headViewRect;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.view addSubview:headView];
    
    // 添加模糊效果. dark暗系风格, light 亮系风格, extra light 附加额外的亮光
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = headViewRect;
    [imageView addSubview:effectView];
    [headView addSubview:imageView];
    
    // 用户头像
//    userHeadImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:userDataArray[0][0][@"subTitle"]]]
    CGSize userHeadImageSize = CGSizeMake(80, 80);
    userHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenSize.width / 2 - userHeadImageSize.width / 2, headView.frame.size.height - userHeadImageSize.height - 60, userHeadImageSize.width, userHeadImageSize.height)];
    
    userHeadImage.layer.cornerRadius = userHeadImageSize.width/2;
    userHeadImage.layer.masksToBounds = true;
    [effectView addSubview:userHeadImage];
    
    // 用户昵称
    CGSize userNickNameSize = CGSizeMake(ScreenSize.width / 2, 21);
    userNickName = [[UILabel alloc] initWithFrame:CGRectMake(ScreenSize.width / 2 - userNickNameSize.width / 2, userHeadImage.frame.origin.y + userHeadImage.frame.size.height + 10, userNickNameSize.width, userNickNameSize.height)];
    userNickName.textAlignment = NSTextAlignmentCenter;
    userNickName.font = [UIFont systemFontOfSize:14];
    userNickName.textColor = [UIColor whiteColor];
    userNickName.text = @"菩提老组";
    [effectView addSubview:userNickName];
    
    CGSize userSignSize = CGSizeMake(ScreenSize.width / 2, 21);
    userSign = [[UILabel alloc] initWithFrame:CGRectMake(ScreenSize.width/2 - userSignSize.width/2, userNickName.center.y + userNickName.frame.size.height - 5, userSignSize.width, userSignSize.height)];
    userSign.textAlignment = userNickName.textAlignment;
    userSign.font = [UIFont systemFontOfSize:12];
    userSign.textColor = userNickName.textColor;
    userSign.text = @"给我力量，让我可以翱翔！";
    [effectView addSubview:userSign];
    
#pragma mark 设置导航栏左右button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(settingsWithRightBarButton)];
}



#pragma mark 初始化view
- (void)initView {
    
    #pragma mark 设置列表信息
    _personTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStyleGrouped];
    
    TableViewCellConfigureBlock personViewCellConfigureBlock = ^(PersonViewCell * personCell, NSDictionary * dic, NSIndexPath * indexPath){
        [personCell configureCellWithDic:dic withIndex:indexPath];
    };
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Person" ofType:@"plist"];
    _personViewCellDataArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    self.personViewCellDataSource = [[TableViewDataSource alloc] initWithItems:_personViewCellDataArray
                                                                cellIdentifier:PersonViewCellIdentifier
                                                                     cellBlock:personViewCellConfigureBlock];
    
    _personTableView.delegate = self;
    _personTableView.dataSource = self.personViewCellDataSource;
    
    [_personTableView registerClass:[PersonViewCell class] forCellReuseIdentifier:PersonViewCellIdentifier];
    
    [self.view addSubview:_personTableView];
}

- (void)settingsWithRightBarButton {
//    NSLog(@"点击了设置");
    HCShowTabBarView(false);
    [self.navigationController pushViewController:[SettingsViewController new] animated:true];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    PersonViewCell * cell = (PersonViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString * title = cell.textLabel.text;
    if ([title  isEqual: @"个人设置"]) {
        HCShowTabBarView(false);
        [self.navigationController pushViewController:[PersonInfoViewController new] animated:true];
    } else if ([title isEqualToString:@"上传作品"] || [title isEqualToString:@"上传菜谱"] || [title isEqualToString:@"我的收藏"]) {
        HCShowTabBarView(false);
        MyZoneViewController * nextVC = [MyZoneViewController new];
        nextVC.selectType = (int)indexPath.row;
        nextVC.navTitle = title;
        [self.navigationController pushViewController:nextVC animated:true];
    } else {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelButton = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction * okButton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"退出登录");
        }];
        [alert addAction:cancelButton];
        [alert addAction:okButton];
        [self presentViewController:alert animated:true completion:nil];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return headViewRect.size.height + 20;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}


#pragma mark- UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = _personTableView.contentOffset.y;
    if (y < 0) {
        [self resetHeadViewFrame:y];
    } else {
        CGRect frame = imageView.frame;
        frame.origin.y = -y;
        imageView.frame = frame;
    }
}

- (void)resetHeadViewFrame:(CGFloat)y {
    CGRect frame = imageView.frame;
    frame.origin.y = 0;
    frame.size.height = headViewRect.size.height + -y;
    effectView.frame = frame;
    imageView.frame = frame;
    
    userHeadImage.frame = CGRectMake(ScreenSize.width / 2 - userHeadImage.frame.size.width / 2, frame.size.height - 80 - 60, 80, 80);
    userNickName.frame = CGRectMake(ScreenSize.width / 2 - userNickName.frame.size.width / 2, userHeadImage.center.y + userHeadImage.frame.size.height / 2 + 10, userNickName.frame.size.width, userNickName.frame.size.height);
    
    userSign.frame = CGRectMake(ScreenSize.width/2 - userSign.frame.size.width/2, userNickName.center.y + userNickName.frame.size.height / 2 + 5, userSign.frame.size.width, userSign.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
