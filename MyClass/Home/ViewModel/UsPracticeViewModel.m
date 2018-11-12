//
//  UsPracticeViewModel.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "UsPracticeViewModel.h"
#import "UsPracticeRequestModel.h"
#import "RequestManager.h"
#import "CommonMacro.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Utils.h"
@implementation UsPracticeViewModel
@dynamic title;
- (instancetype)initWithPracticeModel:(UsPractice *)model naviImpl:(id<MiuNavigationProtocol>)naviImpl {
    if (self = [super init]) {
        [self initialize];
        _model = model;
        _naviImpl = naviImpl;
    }
    return self;
}

- (void)initialize {
    [super initialize];
    self.title = @"首页";
    self.shouldPullUpToRefresh = YES;
    self.shouldPullDownToRefresh = YES;
    self.shouldEndRefreshingWithNoMoreData = NO;
}

- (NSString *)title {
    return _model.title;
}

- (NSString *)message {
    return _model.message;
}

- (NSString *)count {
    return _model.count;
}

+ (void)getUsPracticeDataSource:(void(^)(int code,NSString * msg,UsPracticeResponseModel *dataSource))completion {
    UsPracticeRequestModel * request = [UsPracticeRequestModel new];
    request.userid = @"1001";
    [[RequestManager sharedRequestManager]sendRequest:request successed:^(BaseResponseModel *response) {
        UsPracticeResponseModel * usPractice = (UsPracticeResponseModel *)response;
        if (completion) {
            completion(CODE_REQUEST_SUCCEED,nil,usPractice);
        }
    } failed:^(int errorCode, NSString *errorMsg) {
        if (completion) {
            completion(errorCode,errorMsg,nil);
        }
    }];
}

@end
