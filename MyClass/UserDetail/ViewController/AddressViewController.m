//
//  AddressViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/20.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressViewCell.h"
#import "AddStreetViewController.h"
#import "AddressRequest.h"
#import "AddressResponse.h"
#import "RequestManager.h"

@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavTitle];
    [self setBackBtn];
    [self setNextBtn];
    [self setupView];
    [self getDataSource];
}

- (void)addNavTitle {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"收货地址管理";
    title.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = title;
}

- (void)setBackBtn {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_nav_close"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackItem)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)clickBackItem {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNextBtn {
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"新增地址" style:UIBarButtonItemStylePlain target:self action:@selector(clickAddDress)];
    self.navigationItem.rightBarButtonItem= rightButton;
}

- (void)clickAddDress {
    AddStreetViewController *addStreet = [AddStreetViewController new];
    [self.navigationController pushViewController:addStreet animated:YES];
}

- (void)getDataSource {
    AddressRequest *request = [AddressRequest new];
    request.userid = @"18987876899";
    
    [[RequestManager sharedRequestManager]sendRequest:request successed:^(BaseResponseModel *response) {
        AddressResponse * addressResponse = (AddressResponse *)response;
        [_dataSource addObjectsFromArray:addressResponse.data];
        [_tbView reloadData];
    } failed:^(int errorCode, NSString *errorMsg) {
        NSLog(@"errorCode :%d , errorMsg :%@", errorCode,errorMsg);
        [_tbView reloadData];
    }];
}

- (void)setupView {
    _tbView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    _dataSource = [NSMutableArray array];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * reuseIdentifier = @"reuseIdentifier";
    AddressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[AddressViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    AddressData *item = [_dataSource objectAtIndex:indexPath.row];
    [cell setCellValue:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}
@end
