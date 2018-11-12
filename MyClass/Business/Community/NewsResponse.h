//
//  NewsResponseDetail.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseResponseModel.h"

@protocol News
@end

@interface NewsResponse : BaseResponseModel
@property(nonatomic,strong)NSArray<News> * data;
@property(nonatomic,assign)int successCode;
@property(nonatomic,copy)NSString *errorMessage;
@property(nonatomic,assign)int errorCode;
@property(nonatomic,assign)int total;
@end

@interface News:BaseResponseModel
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *picurl;
@property(nonatomic,strong)NSDate *buildtime;
@property(nonatomic,strong)NSDate *sendtime;
@property(nonatomic,strong)NSDate *starttime;
@property(nonatomic,strong)NSDate *endtime;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,assign)int share;
@property(nonatomic,assign)int praise;
@end
