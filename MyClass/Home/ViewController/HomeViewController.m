//
//  HomeViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/5.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "HomeViewController.h"
#import "BasicControlsUtil.h"
#import "CommonMacro.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UsPracticeViewController.h"
#import "UsCourseViewController.h"

typedef NS_ENUM(NSUInteger,ApprovalType) {
    US_PRACTICE = 0,  // 我的练习
    US_COURSE = 1,     //我的课程
};

@interface HomeViewController ()
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,assign)ApprovalType approvaType;
@property(nonatomic,strong)UISegmentedControl *segmentedControl;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    [self setViewTitle];
    [self setBoxStall];
}

- (void)setViewTitle {
    for (int i = 0 ; i < 3; i++) {
        NSInteger index = i % 3;
        // 圆角按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.tag = i;//这句话不写等于废了
        btn.frame = CGRectMake(index * (SCREEN_WIDTH/3), 100 , SCREEN_WIDTH / 3, 44);
        [self.view addSubview:btn];
        [btn setTitle:[NSString stringWithFormat:@"obito"] forState:UIControlStateNormal];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            UIButton *btnNew = (UIButton *)x;
            NSString * btnTitle = btnNew.titleLabel.text;
            NSLog(@"点击了按钮 :%@",btnTitle);
        }];
        _btn = btn;
    }
}

- (void)setBoxStall {
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, UIControlYLength(_btn) + 4, SCREEN_WIDTH, 48)];
    toolBar.barStyle = UIBarStyleDefault;
    [self.view addSubview:toolBar];
    
    UISegmentedControl *segementControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"我的练习",@"我的课程",nil]];
    segementControl.tintColor = BlueColor;
    [segementControl setFrame:CGRectMake(15, 8, SCREEN_WIDTH - 30, 32)];
    [segementControl setSelectedSegmentIndex:0];
    [toolBar addSubview:segementControl];
    [segementControl addTarget:self action:@selector(segmentedcontrolChangeValue) forControlEvents:UIControlEventTouchUpInside];
    _segmentedControl = segementControl;
}

-(void)segmentedcontrolChangeValue
{
    NSInteger index =_segmentedControl.selectedSegmentIndex;
    if (index == 0) {
        _approvaType = US_PRACTICE;
        NSLog(@"nbfjdkmf");
    }else{
        _approvaType = US_COURSE;
        NSLog(@"8798909");
    }
}
@end
