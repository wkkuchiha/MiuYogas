//
//  MiuYogaViewModel.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MiuViewModelServices.h"


@interface MiuYogaViewModel : NSObject


@property(nonatomic,strong)id<MiuViewModelServices> service;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)RACSubject *errors;
@property(nonatomic,strong)RACSubject *willDisapperSignal;
@property(nonatomic,copy)NSDictionary *params;
// stack 是否取消掉左滑pop到上一层的功能（栈底控制器无效），默认为NO，不取消)
@property(nonatomic,assign)BOOL interactivePopDisabled;
// 是否隐藏控制器导航栏
@property(nonatomic,assign)BOOL prefersNavigationBarBottomLineHidden;
- (void)initialize;
- (instancetype)initWithServices:(id<MiuViewModelServices>)services params:(NSDictionary *)params;
@end
