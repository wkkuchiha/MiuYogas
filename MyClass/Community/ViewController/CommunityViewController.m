//
//  CommunityViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/5.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "CommunityViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CommonMacro.h"
#import "HttpErrorMacro.h"
#import "CommunityBannerRequest.h"
#import "CommunityBannerResponse.h"
#import "RequestManager.h"
#import "UIScrollView+Custom.h"
#import "UIPageControl+Custom.h"
#import "TopicNewsRequest.h"
#import "TopicNewsResponse.h"
#import "CommunityViewModel.h"
#import "CommunityViewCell.h"
#import "NewsDetailViewController.h"

@interface CommunityViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,copy)NSArray *bannerData;
@property(nonatomic,strong)CommunityBanner *bannerSource;
@property(nonatomic,copy)NSMutableArray *dataSource;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIPageControl *pageCtrl;
@property(nonatomic,copy)NSArray * btnImage;
@property(nonatomic,copy)NSArray * btnImageSelect;
@property(nonatomic,strong)UIButton *tacticsBtn;
@property(nonatomic,strong)CommunityViewModel *viewModel;
@property(nonatomic,copy)NSMutableArray *topicNewsDataSource;
@property(nonatomic,strong)UIScrollView * topicNews;
@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,copy)NSMutableArray  *tbDataSource;
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self getBannerDataSource];
    [self initBanners];
    [self addSportsBtn];
    [self getTopicNewDataSource];
    [self topicNew];
    [self getNewsDetailDataSource];
    [self createTbView];
}

- (void)setupView {
    self.title = @"社区";
    _dataSource = [NSMutableArray array];
    _dataSource = [NSMutableArray arrayWithObjects:@"user_keep_icon",@"user_order_icon", nil];
    _btnImage = @[@"tale",@"habit",@"plot"];
    _btnImageSelect = @[@"tale_select",@"habit_select",@"plot_select"];
    _topicNewsDataSource = [NSMutableArray array];
    _tbDataSource = [NSMutableArray array];
}

- (void)initBanners {
    _scroll = [UIScrollView initWithScrollFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREENH_HEIGHT/4) imgaCount:_dataSource.count imgaDataSource:_dataSource];
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
     
    _pageCtrl = [UIPageControl initWithPageCtrlFrame:CGRectMake(SCREEN_WIDTH - 50, 70, 50, 30) pageCount:_dataSource.count];
    [self.view addSubview:_pageCtrl];
    
    [self addtimer]; // 添加定时器
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _scroll) {
        CGPoint offset = scrollView.contentOffset;
        _pageCtrl.currentPage = offset.x / _scroll.frame.size.width + 0.5; //计算当前的页码
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addtimer];
}

// 拖拽的时候调用
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    // 移除定时器
    [self removeTimer];
}

- (void)addtimer {    
    _timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    if ([_timer isValid]) {
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    } else {
        [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    }
    [_timer fire];
}

- (void)removeTimer {
    [_timer invalidate];
}

- (void)nextImage {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
    long page = _pageCtrl.currentPage;
    if (page < _dataSource.count - 1) {
        page = 0 ;
    } else {
        page ++;
    }
    [_scroll setContentOffset:CGPointMake(SCREEN_WIDTH * page, 0) animated:YES];
    [UIView commitAnimations];
}

- (void)removetimer {
    [_timer invalidate];
}

- (void)getTopicNewDataSource {
    [CommunityViewModel getTopicNewsDataSource:^(int code, NSString *msg, TopicNewsResponse *dataArray) {
        if (code == CODE_REQUEST_SUCCEED) {
            for (TopicNews *banners  in dataArray.data) {
                [_topicNewsDataSource addObject:banners.picurl];
            }
        } else {
            LRLog(@"------ code : %d ,  msg :%@",code,msg);
        }
    }];
}

// 热门话题
- (void)topicNew {
    NSArray *data = @[@"tale",@"habit",@"plot"];
    _topicNews = [UIScrollView initWithScrollFrame:CGRectMake(10, UIControlYLength(_tacticsBtn) + 20, SCREENH_HEIGHT/3, 100) imgaCount:3 imgaDataSource:data];
    _topicNews.backgroundColor = RedColor;
    [self.view addSubview:_topicNews];
}

- (void)addSportsBtn {
    NSArray * btnTitles = @[@"瘦身故事",@"运动习惯",@"饮食攻略"];
    for (int i = 0; i< 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * (SCREEN_WIDTH /3), UIControlYLength(_scroll), SCREEN_WIDTH / 3, 64);
        btn.tag = 100 + i;
        [btn setImage:[UIImage imageNamed:_btnImage[i]] forState:UIControlStateNormal];
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setImage:[UIImage imageNamed:_btnImage[i]] forState:UIControlStateNormal];
        [btn setImageEdgeInsets: UIEdgeInsetsMake(-15, (btn.bounds.size.width-btn.imageView.bounds.size.width)*0.5, 0, 0)];
        [btn setTitleEdgeInsets: UIEdgeInsetsMake(btn.imageView.bounds.size.height + 5, - btn.imageView.bounds.size.width + 5, 0, 0)];
        [btn setImage:[UIImage imageNamed:_btnImageSelect[i]] forState:UIControlStateSelected];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        _tacticsBtn = btn;
    }
}

- (void)clickBtn:(UIButton *)sender {
    switch (sender.tag - 100) {
        case 0:
            [self initReduceWeigh];
            break;
        case 1:
            [self initSports];
            break;
        case 2:
            [self initActivity];
            break;
        default:
            break;
    }
}

- (void)initReduceWeigh {
    
}

- (void)initSports {
    
}

- (void)initActivity {
    
}

- (void)getBannerDataSource {
    [CommunityViewModel getBannerDataSource:^(int code, NSString *msg, CommunityBannerResponse *dataArray) {
        if (code == CODE_REQUEST_SUCCEED) {
            for (CommunityBanner *banners  in dataArray.data) {
                [_dataSource addObject:banners.picurl];
            }
        } else {
            LRLog(@"------ code : %d ,  msg :%@",code,msg);
        }
    }];
}

- (void)getNewsDetailDataSource {
    [CommunityViewModel getNews:^(int code, NSString *msg, NewsResponse *dataSource) {
        if (code == CODE_REQUEST_SUCCEED) {
            for (News *news in dataSource.data) {
                [_tbDataSource addObject:news];
            }
        } else {
            LRLog(@"------ code : %d ,  msg :%@",code,msg);
        }
    }];
}

- (void)createTbView {
    _tbView = [[UITableView alloc]initWithFrame:CGRectMake(10, UIControlYLength(_topicNews) + 20, SCREEN_WIDTH - 20, SCREENH_HEIGHT) style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tbDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"Identifier";
    CommunityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier]
    ;
    if (cell == nil) {
        cell = [[CommunityViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    News * news = [_tbDataSource objectAtIndex:indexPath.row];
    [cell setTableCellData:news bottomStyle:YES];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    News *news = [_dataSource objectAtIndex:indexPath.row];
    NewsDetailViewController * NewsDetail = [[NewsDetailViewController alloc]initWithData:news];
    [self.navigationController pushViewController:NewsDetail animated:YES];
}
@end

