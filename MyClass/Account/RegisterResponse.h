//
//  RegisterResponse.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/8.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseResponseModel.h"

@protocol UserRegister
@end

@interface RegisterResponse : BaseResponseModel
@property(nonatomic,strong)NSArray<UserRegister> * data;
@property(nonatomic,assign)int successCode;
@property(nonatomic,copy)NSString *errorMessage;
@property(nonatomic,assign)int errorCode;
@property(nonatomic,assign)int total;
@end

@interface UserRegister:BaseResponseModel
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *token;
@end
