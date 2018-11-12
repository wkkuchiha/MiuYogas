//
//  NewsDetailViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "CommunityViewCell.h"
#import "NewDetailViewCell.h"
#import "CommunityViewModel.h"

@interface NewsDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,strong)News *news;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation NewsDetailViewController

- (instancetype)initWithData:(News *)dataSource {
    if (self = [super init]) {
        _news = dataSource;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    _tbView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    _dataSource = [NSMutableArray array];
}

- (void)getNewsDetailDataSource {
    [CommunityViewModel getNewsDetail:^(int code, NSString *msg, NewsDetailResponse *dataSource) {
        if (code == CODE_REQUEST_SUCCEED) {
            for (NewsDetail *news in dataSource.data) {
                [_dataSource addObject:news];
            }
        } else {
            LRLog(@"------ code : %d ,  msg :%@",code,msg);
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CommunityViewCell *cell = [[CommunityViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell setTableCellData:_news bottomStyle:NO];
        return cell;
    } else if (indexPath.section == 1) {
        NewDetailViewCell *cell = [[NewDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NewsDetail * newsDetail = [_dataSource firstObject];
        [cell setNewsDetailData:newsDetail];
        return cell;
    }
    return nil;
}
@end
