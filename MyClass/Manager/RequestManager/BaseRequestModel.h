//
//  BaseRequestModel.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/2.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BaseRequestModel : JSONModel

@property (nonatomic, assign) NSInteger retriesCount; //重试次数
//基本参数
@property (nonatomic, copy) NSString *processTime; //请求时间
@property (nonatomic, copy) NSString *deviceId;    //设备号码
@property (nonatomic, copy) NSString *authTkn;     //token


- (instancetype)init;

- (NSString *)getRequestURL;

- (NSString *)getMethodName;
@end
