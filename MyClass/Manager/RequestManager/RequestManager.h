//
//  RequestManager.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/2.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequestModel.h"
#import "BaseResponseModel.h"
#import "ARCSingletonTemplate.h"
#import "HttpErrorMacro.h"

typedef void (^RequsetHandler)(NSInteger stateCode, NSString *errorMsg);

typedef void (^RequsetDataHandler)(NSInteger stateCode, NSString *errorMsg,BaseResponseModel *response);

//请求成功后回调的代码块,参数是请求成功对应的响应对象
typedef void (^RequestSuccessedHandler)(BaseResponseModel *response);

//请求失败回调的代码块
typedef void (^RequestFailedHandler)(int errorCode, NSString *errorMsg);


/**
 * 请求-响应管理类，初始化一个网络引擎，并初始化一个队列，
 * 将请求放入队列中，每个请求发送时启动一个线程向服务端发送，服务端收到请求后返回响应，
 * 请求对应的线程接受响应，并返回到该对象。对象处理响应，并解析成请求对应的响应类返回给界面。
 */
@interface RequestManager : NSObject

//单例
SYNTHESIZE_SINGLETON_FOR_HEADER(RequestManager);

/**
 *  发送一个请求到服务端
 *
 *  @param request 请求
 *  @param successedHandler 请求成功后回调，返回结果为响应对应的对象
 *  @param failedHandler 请求失败后回调
 */
- (void)sendRequest:(BaseRequestModel *)request successed:(RequestSuccessedHandler)successedHandler failed:(RequestFailedHandler)failedHandler;

//检查网络是连接
+ (BOOL)isNetWorkReachable;

@end
