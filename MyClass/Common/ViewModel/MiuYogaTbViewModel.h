//
//  MiuYogaTbViewModel.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "MiuYogaViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MiuYogaTbViewModel : MiuYogaViewModel
@property(nonatomic,copy)NSArray *dataSource;
@property(nonatomic,assign)UITableViewStyle style;
@property(nonatomic,assign)BOOL shouldPullDownToRefresh; // 是否支持下拉刷新
@property(nonatomic,assign)BOOL shouldPullUpToRefresh; // 是否支持上拉刷新
@property(nonatomic,assign)BOOL shouldEndRefreshingWithNoMoreData; // 当数据不够时是否显示下拉刷新的按钮
@property(nonatomic,assign)BOOL shouldMultiSections; // 是否显示多个分组
@property(nonatomic,assign)NSInteger currentPage; // 当前页面
@property(nonatomic,assign)NSInteger totalPage; // 总页面
@property(nonatomic,assign)RACCommand *didSelectCommand;
@property(nonatomic,assign)RACCommand *requestRemoteDataCommand; // 网络请求
@property(nonatomic,assign)BOOL disableNetwork; // 无网络
- (id)fetchLoadData;
- (BOOL(^)(NSError *error))requestRemoteDataErrorsFilter; // 请求的错误信息
// 在当前页之前的所有数据
- (NSInteger)offsetForPage:(NSInteger)page;
// 当前请求的是多少页
- (RACSignal *)requestRemoteDataSignalWithPage:(NSInteger)page;
@end
