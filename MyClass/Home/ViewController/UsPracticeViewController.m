//
//  UsPracticeViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/23.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "UsPracticeViewController.h"
#import "BasicControlsUtil.h"
#import "CommonMacro.h"
#import "UIView+SDAutoLayout.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UsPracticeViewCell.h"
@interface UsPracticeViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton * customSchedule;
@end

@implementation UsPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  practiceAndSearch];
    [self setupView];
}

- (void)practiceAndSearch {
    UIView * practice = [[UIView alloc]initWithFrame:CGRectMake(20, 10,SCREEN_WIDTH - 40, 44)];
    [self.view addSubview:practice];
    practice.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentCenter backGroundColor:nil tintColor:nil textFont:BigFont];
    label.text = @"我的练习";
    label.frame = CGRectMake(0, UIControlYLength(practice) + 4, SCREEN_WIDTH - 100, 44);
    [practice addSubview:label];
    
    UIButton * addPractice = [BasicControlsUtil customBtnTextColor:nil backGroundColor:nil titleFont:SmallFont image:nil];
    [practice addSubview:addPractice];
    [[addPractice rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"点击事件");
    }];
    
    UIButton * searchBtn = [BasicControlsUtil customBtnTextColor:nil backGroundColor:nil titleFont:SmallFont image:nil];
    [practice addSubview:searchBtn];
    [[searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"搜索事件");
    }];
    
    UIButton * customSchedule = [BasicControlsUtil customBtnTextColor:nil backGroundColor:nil titleFont:SmallFont image:nil];
    [practice addSubview:customSchedule];
    [[customSchedule rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"定制课表");
    }];
    _customSchedule = customSchedule;
}

- (void)setupView {
    // 注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UsPracticeViewCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"UsPracticeViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
