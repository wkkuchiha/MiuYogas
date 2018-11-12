//
//  LoginResponse.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseResponseModel.h"

@protocol LoginInfo
@end

@interface LoginResponse : BaseResponseModel
@property(nonatomic,strong)NSArray<LoginInfo> * data;
@property(nonatomic,assign)int successCode;
@property(nonatomic,copy)NSString *errorMessage;
@property(nonatomic,assign)int errorCode;
@property(nonatomic,assign)int total;
@end

@interface LoginInfo:BaseResponseModel
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *token;
@end
