//
//  PersonalDataViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/6.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "PersonalDataViewCell.h"
#import "PersonalDataRequest.h"
#import "PersonalDataResponse.h"
#import "RequestManager.h"
#import "UserDetailModel.h"
#import "GeneralDataCache.h"

@interface PersonalDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,copy)NSArray *dataSource;
@property(nonatomic,strong)PersonalDataViewCell * personalView;
@property(nonatomic,strong)UserDetailModel *detailModel;
@end

@implementation PersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self initDataSource];
}

- (void)initDataSource {
    
    PersonalDataRequest * request = [[PersonalDataRequest alloc]init];
    request.userid = @"12345";
//    request.userid = [GeneralDataCache sharedGeneralDataCache].accountName;
    [[RequestManager sharedRequestManager] sendRequest:request successed:^(BaseResponseModel *response) {
        PersonalDataResponse * personal = (PersonalDataResponse *)response;
        NSString * nickname = nil;
        for (PersonalData *data in personal.data) {
            nickname = data.nickname;
        }
    } failed:^(int errorCode, NSString *errorMsg) {
        NSLog(@"--------- errorCode :%d , errorMsg :%@", errorCode,errorMsg);
    }];
}

- (void)setupView {
    _tbView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    
    _dataSource = [NSArray array];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalDataViewCell * personaldata = [[PersonalDataViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [personaldata setViewValue:@"数据"];
    return personaldata;
}
@end
