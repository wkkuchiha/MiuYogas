//
//  CommunityViewModel.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunityBannerRequest.h"
#import "CommunityBannerResponse.h"
#import "RequestManager.h"
#import "CommonMacro.h"
#import "TopicNewsRequest.h"
#import "TopicNewsResponse.h"
#import "NewsRequest.h"
#import "NewsResponse.h"
#import "NewsDetailRequest.h"
#import "NewsDetailResponse.h"
@interface CommunityViewModel : NSObject
+ (void)getBannerDataSource:(void(^)(int code,NSString * msg,CommunityBannerResponse *dataSource))completion;

+ (void)getTopicNewsDataSource:(void(^)(int code,NSString * msg,TopicNewsResponse *dataSource))completion;

+ (void)getNews:(void(^)(int code , NSString *msg, NewsResponse *dataSource))completion;

+ (void)getNewsDetail:(void(^)(int code , NSString *msg, NewsDetailResponse *dataSource))completion;
@end
