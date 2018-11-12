//
//  NewsDetailResponse.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseResponseModel.h"

@protocol NewsDetail
@end

@interface NewsDetailResponse : BaseResponseModel
@property(nonatomic,strong)NSArray<NewsDetail> * data;
@property(nonatomic,assign)int successCode;
@property(nonatomic,copy)NSString *errorMessage;
@property(nonatomic,assign)int errorCode;
@property(nonatomic,assign)int total;
@end

@interface NewsDetail : BaseResponseModel
@property(nonatomic,strong)NSNumber * commentCout;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *intervalTime;
@property(nonatomic,copy)NSString *text;
@end
