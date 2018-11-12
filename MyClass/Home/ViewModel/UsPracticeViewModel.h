//
//  UsPracticeViewModel.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsPracticeResponseModel.h"
#import "MiuYogaTbViewModel.h"
#import "MiuNavigationProtocol.h"
@interface UsPracticeViewModel :MiuYogaTbViewModel

@property(nonatomic,strong)UsPractice *model;
// 如下几个属性能体现出MVVM的精髓
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *count;

// 为实现页面跳转而创建，和本类无关
@property (nonatomic, strong) id<MiuNavigationProtocol>naviImpl;
- (instancetype)initWithPracticeModel:(UsPractice *)model naviImpl:(id<MiuNavigationProtocol>)naviImpl;

@end
