//
//  RequestManager.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/2.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "RequestManager.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "Utils.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import <objc/runtime.h>
static const NSInteger MAX_RETRIES_COUNT = 1;   //接口失败后最大重试次数，默认重试一次

@interface RequestManager () {
    BOOL _hasPushLoginVC;
    NSString    *_carrierName;
    NSString    *_networkType;
}

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation RequestManager

SYNTHESIZE_SINGLETON_FOR_CLASS(RequestManager);

- (id)init {
    self = [super init];
    if (self) {
        _hasPushLoginVC = NO;
        self.manager = [AFHTTPSessionManager manager];
        
//        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
//        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        self.manager.requestSerializer.timeoutInterval = 60.0f;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    _networkType = @"Unknown";
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    _networkType = @"NoNetwork";
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    _networkType = @"WWAN";
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    _networkType = @"WIFI";
                    break;
                default:
                    _networkType = @"Unknown";
                    break;
            }
        }];
        [self getCarrierName];
    }
    return self;
}

-(void)dealloc {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

-(void)getCarrierName {
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry= [carrier carrierName];
    _carrierName = currentCountry;
}

- (void)sendRequest:(BaseRequestModel *)request successed:(RequestSuccessedHandler)successedHandler failed:(RequestFailedHandler)failedHandler {
    if (request == nil) {
        return;
    }
    if (![RequestManager isNetWorkReachable]) {
        if (failedHandler) {
            failedHandler(CODE_NO_NETWORK, MSG_NO_NETWORK);
        };
        return;
    }
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    NSString *URLString = [request getRequestURL];
    NSString *jsonString = [request toJSONString];
    
    NSDictionary *body = [[NSDictionary alloc] initWithObjectsAndKeys:jsonString,@"Json", nil];
    
    [self.manager POST:URLString parameters:body progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
       
        NSError *error = nil;
        NSData *response = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:response encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        
        [self handleResponseWithData:json withRequest:request successed:successedHandler failed:failedHandler];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970] - startTime;
        if(time > 20){
            if (failedHandler) {
                failedHandler(CODE_CAN_NOT_CONNECT, MSG_CAN_NOT_CONNECT);
            }
            return;
        }
        //重试
        if(request.retriesCount < MAX_RETRIES_COUNT){
            [self sendRequest:request successed:successedHandler failed:failedHandler];
            request.retriesCount ++;
        }else{
            if (failedHandler) {
                failedHandler(CODE_CAN_NOT_CONNECT, MSG_CAN_NOT_CONNECT);
            }
        }
    }];
}

- (void)handleResponseWithData:(NSString *)json withRequest:(BaseRequestModel *)request successed:(RequestSuccessedHandler)successedHandler failed:(RequestFailedHandler)failedHandler {
    NSDictionary *data = [Utils parshJsonString:json];
    NSString *parkSuccessCode = [data  objectForKey:@"successCode"];
    if (![Utils  isEmpty:parkSuccessCode] && [parkSuccessCode  intValue]==1) {
        BaseResponseModel *response = [self getResponseFromRequest:request withData:data];
        successedHandler(response);
        return;
    } else {
        if (![Utils  isEmpty:parkSuccessCode] && [parkSuccessCode  intValue]== 0) {
            int code = 1;
            NSNumber *value = [data objectForKey:@"errorCode"];
            if (value && ![value isKindOfClass:[NSNull class]]) {
                code = [value intValue];
            }
            
            NSString *errorMsg = [data objectForKey:@"errorMessage"];
            if (code == 52 || code == 91 || code == 94 || code == 95 || code == 96 || code == 97) {
                if ([Utils isEmpty:errorMsg]) {
                    errorMsg = @"Token失效,请重新登录";
                }
                [self goToLoginPage];
            } else {
                failedHandler(code, errorMsg);
            }
            return;
        }
    }
    
    BaseResponseModel *response = [self getResponseFromRequest:request withData:data];
    if (!response) {
        failedHandler(CODE_CAN_NOT_FOUND_RESPONSE, MSG_CAN_NOT_FOUND_RESPONSE);
        return;
    }
    successedHandler(response);
}

- (void)goToLoginPage {
    if (_hasPushLoginVC) {
        return;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *viewController;
    if (appDelegate.window.rootViewController.presentedViewController) {
        viewController = appDelegate.window.rootViewController.presentedViewController;
    } else {
        viewController = appDelegate.window.rootViewController;
    }
    
    if (viewController) {
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *)viewController;
            BOOL hasLoginView = NO;
            for (UIViewController *viewController in navigationController.viewControllers) {
                if ([viewController isKindOfClass:[LoginViewController class]]) {
                    [navigationController popToViewController:viewController animated:YES];
                    hasLoginView = YES;
                    break;
                }
            }
            if (!hasLoginView) {
                LoginViewController *viewContoller = [[LoginViewController alloc] init];
                [navigationController pushViewController:viewContoller animated:YES];
            }
        }
        _hasPushLoginVC = YES;
    }
}

- (BaseResponseModel *)getResponseFromRequest:(JSONModel *)request withData:(NSDictionary *)data {
    if (request == nil || data == nil) {
        return nil;
    }
    
    NSString *requestClassName = [NSString stringWithUTF8String:object_getClassName(request)];
    if (!requestClassName) {
        return nil;
    }
    if ([requestClassName hasSuffix:@"Request"]) {
        //替换字符串生成对应的RESPONSE类名称
        NSString *responseClassName = [requestClassName stringByReplacingOccurrencesOfString:@"Request" withString:@"Response"];
        //反射出对应的类
        Class responseClass = NSClassFromString(responseClassName);
        //没找到该类，或出错
        if (!responseClass) {
            return nil;
        }
        //生成对应的对象并返回
        NSError *error;
        BaseResponseModel *response = [[responseClass alloc] initWithDictionary:data error:&error];
        if (error) {
            return nil;
        }
        return response;
    }
    
    return nil;
}

#pragma mark - 网络状态是否可用；
+ (BOOL)isNetWorkReachable {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable;
}
@end

