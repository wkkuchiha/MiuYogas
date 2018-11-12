//
//  MiuViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "MiuViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MiuNavigationProtocol.h"
#import "MiuYogaViewModel.h"
#import "CommonMacro.h"

@implementation MiuViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    MiuViewController *controller = [super allocWithZone:zone];
    @weakify(controller);
    [[controller rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(controller);
        [controller bindViewModel];
    }];
    return controller;
}

- (instancetype)initWithViewModel:(MiuYogaViewModel *)viewModel {
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)bindViewModel {
    RAC(self.navigationItem,title) = RACObserve(self, viewModel.title);
    [self.viewModel.errors subscribeNext:^(id x) {
        NSLog(@"RAC使用不当");
    }];
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
    
    _tbView.contentInset = _contentInset;
    [_tbView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    // 适配iPhoneX
    if (@available(iOS 11.0,*)) {
        AdjustsScrollViewInsets_Never(_tbView);
        /// iOS 11上发生tableView顶部有留白，原因是代码中只实现了heightForHeaderInSection方法，而没有实现viewForHeaderInSection方法。那样写是不规范的，只实现高度，而没有实现view，但代码这样写在iOS 11之前是没有问题的，iOS 11之后应该是由于开启了估算行高机制引起了bug。
        _tbView.estimatedRowHeight = 0;
        _tbView.estimatedSectionFooterHeight = 0;
        _tbView.estimatedSectionHeaderHeight = 0;
    }
}

- (void)reloadData {
    return [_tbView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_viewModel.shouldMultiSections) {
        return _viewModel.dataSource.count?_viewModel.dataSource.count:0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel.shouldMultiSections) {
        return [_viewModel.dataSource[section] count];
    }
    return _viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    id obj = nil;
    if (_viewModel.shouldMultiSections) {
        obj = _viewModel.dataSource[indexPath.section][indexPath.row];
    } else {
        obj = _viewModel.dataSource[indexPath.row];
    }
    [self configureCell:cell atIndexPath:indexPath withObject:obj];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tbView deselectRowAtIndexPath:indexPath animated:YES];
    [_viewModel.didSelectCommand execute:indexPath];
}
@end
