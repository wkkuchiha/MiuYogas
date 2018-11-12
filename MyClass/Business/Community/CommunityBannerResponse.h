//
//  CommunityBannerResponse.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/9.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseResponseModel.h"

@protocol CommunityBanner
@end

@interface CommunityBannerResponse : BaseResponseModel
@property(nonatomic,strong)NSArray<CommunityBanner> * data;
@property(nonatomic,assign)int successCode;
@property(nonatomic,copy)NSString *errorMessage;
@property(nonatomic,assign)int errorCode;
@property(nonatomic,assign)int total;
@end

@interface CommunityBanner:BaseResponseModel
@property(nonatomic,copy)NSString *picurl;
@property(nonatomic,copy)NSString *url;
@end
