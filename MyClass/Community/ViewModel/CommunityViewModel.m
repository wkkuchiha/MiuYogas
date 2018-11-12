
//  CommunityViewModel.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "CommunityViewModel.h"

@implementation CommunityViewModel
+ (void)getBannerDataSource:(void (^)(int code, NSString *msg,CommunityBannerResponse *dataSource))completion {
    CommunityBannerRequest * request = [CommunityBannerRequest new];
    request.status = 1;
    request.starttime = @"2018";
    request.endtime = @"2019";
    request.type = [NSNumber numberWithInt:1];
    [[RequestManager sharedRequestManager] sendRequest:request successed:^(BaseResponseModel *response) {
        CommunityBannerResponse *banners = (CommunityBannerResponse *)response;
        if (completion) {
            completion(CODE_REQUEST_SUCCEED,nil,banners);
        }
    } failed:^(int errorCode, NSString *errorMsg) {
        if (completion) {
            completion(errorCode,errorMsg,nil);
        }
    }];
}

+ (void)getTopicNewsDataSource:(void(^)(int code,NSString * msg,TopicNewsResponse *dataSource))completion {
    TopicNewsRequest *request = [TopicNewsRequest new];
    request.status = 1;
    request.starttime = @"2018";
    request.endtime = @"2019";
    request.type = [NSNumber numberWithInt:1];
    [[RequestManager sharedRequestManager]sendRequest:request successed:^(BaseResponseModel *response) {
        TopicNewsResponse *topicNews = (TopicNewsResponse *)response;
        if (completion) {
            completion(CODE_REQUEST_SUCCEED,nil,topicNews);
        }
    } failed:^(int errorCode, NSString *errorMsg) {
        if (completion) {
            completion(errorCode,errorMsg,nil);
        }
    }];
}

+ (void)getNews:(void(^)(int code , NSString *msg, NewsResponse *dataSource))completion {
    NewsRequest *request = [NewsRequest new];
    [[RequestManager sharedRequestManager] sendRequest:request successed:^(BaseResponseModel *response) {
        NewsResponse * news = (NewsResponse *)response;
        if (completion) {
            completion(CODE_REQUEST_SUCCEED,nil,news);
        }
    } failed:^(int errorCode, NSString *errorMsg) {
        if (completion) {
            completion(errorCode,errorMsg,nil);
        }
    }];
}

+ (void)getNewsDetail:(void(^)(int code , NSString *msg, NewsDetailResponse *dataSource))completion {
    NewsDetailRequest *request = [NewsDetailRequest new];
    [[RequestManager sharedRequestManager] sendRequest:request successed:^(BaseResponseModel *response) {
        NewsDetailResponse * newsDetail = (NewsDetailResponse *)response;
        if (completion) {
            completion(CODE_REQUEST_SUCCEED,nil,newsDetail);
        }
    } failed:^(int errorCode, NSString *errorMsg) {
        if (completion) {
            completion(errorCode,errorMsg,nil);
        }
    }];
}
@end
