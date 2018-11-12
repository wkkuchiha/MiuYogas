//
//  LoginRequest.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseRequestModel.h"
#import "LoginResponse.h"

@interface LoginRequest : BaseRequestModel
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *password;
//@property()NSNumber * rememberdata;
@end
