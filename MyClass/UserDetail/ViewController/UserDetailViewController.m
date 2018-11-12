//
//  UserDetailViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/5.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserDetailViewCell.h"
#import "UserDetailModel.h"
#import "PersonalDataViewController.h"
#import "PersonalDataRequest.h"
#import "PersonalDataResponse.h"
#import "GeneralDataCache.h"
#import "RequestManager.h"
#import "SettingViewController.h"
@interface UserDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,strong)NSArray * dataSource;
@property(nonatomic,strong)PersonalData *personaldata;
@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self requestData];
    
}

- (void)setupView {
    self.title = @"我";
    _tbView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    [self dataSource];
    
    _tbView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tbView.bounds.size.width,20.0f)];
}

- (void)requestData {
    PersonalDataRequest * request = [[PersonalDataRequest alloc]init];
    request.userid = @"10001";
    [[RequestManager sharedRequestManager] sendRequest:request successed:^(BaseResponseModel *response) {
        PersonalDataResponse * personal = (PersonalDataResponse *)response;
        NSString * nickname = nil;
        for (PersonalData *data in personal.data) {
            nickname = data.nickname;
            _personaldata = data;
        }
        [_tbView reloadData];
    } failed:^(int errorCode, NSString *errorMsg) {
        NSLog(@"--------- errorCode :%d , errorMsg :%@", errorCode,errorMsg);
    }];
}

#pragma mark - 懒加载
- (NSArray *)dataSource {
    if (_dataSource == nil) {
        UserDetailModel * mode = [UserDetailModel new];
        mode.dataTitle = @[@"鹏哥"];
        mode.dataImage = @[@"user_order_icon"];
        
        UserDetailModel * mode1 = [UserDetailModel new];
        mode1.dataTitle = @[@"我的订单",@"邀请有礼",@"我的收藏"];
        mode1.dataImage = @[@"user_order_icon",@"user_present_icon",@"user_keep_icon"];
        
        UserDetailModel * model2 = [UserDetailModel new];
        model2.dataTitle = @[@"系统设置"];
        model2.dataImage = @[@"user_setting_icon"];
        
        _dataSource = @[mode,mode1,model2];
    }
    return _dataSource;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section?44:84;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    UserDetailModel *model = _dataSource[section];
    return model.dataTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        UserDetail *headCell = [[UserDetail alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UserDetailModel * model = [_dataSource objectAtIndex:indexPath.section];
        [headCell setValueWithView:[model.dataImage objectAtIndex:indexPath.row] nickname:[model.dataTitle objectAtIndex:indexPath.row] subtitle:@"我的宣言"];
        return headCell;
    } else {
        UserDetailViewCell *cell = [[UserDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UserDetailModel * model = [_dataSource objectAtIndex:indexPath.section];
        [cell setValueWithView:[model.dataImage objectAtIndex:indexPath.row] title:[model.dataTitle objectAtIndex:indexPath.row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        PersonalDataViewController * personalData = [PersonalDataViewController new];
        [self.navigationController pushViewController:personalData animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        // 进入系统设置
        SettingViewController * setting = [SettingViewController new];
        [self.navigationController pushViewController:setting animated:YES];
    }
}
@end

