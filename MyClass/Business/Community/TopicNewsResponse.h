//
//  TopicNewsResponse.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseResponseModel.h"

@protocol TopicNews
@end

@interface TopicNewsResponse : BaseResponseModel
@property(nonatomic,strong)NSArray<TopicNews> * data;
@property(nonatomic,assign)int successCode;
@property(nonatomic,copy)NSString *errorMessage;
@property(nonatomic,assign)int errorCode;
@property(nonatomic,assign)int total;
@end

@interface TopicNews:BaseResponseModel
@property(nonatomic,copy)NSString *picurl;
@property(nonatomic,copy)NSString *url;
@end
