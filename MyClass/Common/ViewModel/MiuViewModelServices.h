
//
//  MiuViewModelServices.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiuNavigationProtocol.h"
#import "RequestManager.h"
#import "CommonMacro.h"
@protocol MiuViewModelServices <NSObject,MiuNavigationProtocol>
// 处理网络层数据
@property (nonatomic, readonly, strong) RequestManager *request;
@end
