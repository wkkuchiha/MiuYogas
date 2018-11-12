//
//  UsPracticeResponseModel.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseResponseModel.h"

@protocol UsPractice
@end

@interface UsPracticeResponseModel : BaseResponseModel
@property(nonatomic,strong)NSArray<UsPractice> * data;
@property(nonatomic,assign)int successCode;
@property(nonatomic,copy)NSString *errorMessage;
@property(nonatomic,assign)int errorCode;
@property(nonatomic,assign)int total;
@end

@interface UsPractice:BaseResponseModel
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *count;
@end
