//
//  SettingViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/19.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "SettingViewController.h"
#import "LogoutResponse.h"
#import "LogoutRequest.h"
#import "ViewHelper.h"
#import "RequestManager.h"
#import "GeneralDataCache.h"
#import "Utils.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "AddressViewController.h"
#import "AboutUsViewController.h"
#import "CommonMacro.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,copy)NSArray *dataSource;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.title = @"系统设置";
    
    _tbView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0?3:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"地址管理";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"版本号";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"关于我们";
        }
    } else {
        cell.textLabel.text = @"退出登陆";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AddressViewController *addRess = [AddressViewController new];
            [self.navigationController pushViewController:addRess animated:YES];
        }
        if (indexPath.row == 2) {
            // 关于我们 
            AboutUsViewController *aboutUs = [[AboutUsViewController alloc]initWithUrl:@"http://localhost:8080/aboutUs" viewTitle:@"关于我们"];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:aboutUs];
            nav.view.backgroundColor = HeaderFooterViewColor;
            nav.navigationBar.tintColor = BlueColor;
            nav.navigationBar.barStyle = UIBarStyleDefault;
            [self presentViewController:nav animated:YES completion:nil];
        }
    } else {
        // 退出登陆
        [self logout];
    }
}

- (void)logout {
    
    LogoutRequest *request = [[LogoutRequest alloc] init];
    [[RequestManager sharedRequestManager] sendRequest:request successed:^(BaseResponseModel *response) {
    
        [ViewHelper showSuccessHUDWithComplition:^{
            
            [[GeneralDataCache sharedGeneralDataCache] setLoginState:[NSNumber numberWithInt:0]];
            [NSUserDefaults resetStandardUserDefaults];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self jumpToIndexViewController];
            }];
        }];
        
    } failed:^(int errorCode, NSString *errorMsg) {
        if ([Utils isEmpty:errorMsg]) {
            errorMsg = @"注销失败,请重试";
        }
        [ViewHelper showFailedHUDWithMessage:errorMsg complition:nil];
    }];
}

- (void)jumpToIndexViewController {
    NSMutableArray *VCs = [self.navigationController.viewControllers mutableCopy];
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if (![viewController isKindOfClass:[LoginViewController class]]) {
            [VCs removeObject:viewController];
        }
    }
    self.navigationController.viewControllers = VCs;
    [self.navigationController pushViewController:[AppDelegate createIndexViewControllerWithNeedLoadUserInfo:YES] animated:YES];
}
@end
