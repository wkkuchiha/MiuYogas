//
//  RegisterRequest.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/8.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseRequestModel.h"

@interface RegisterRequest : BaseRequestModel
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *mobile;
@end
