//
//  LogoutResponse.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/19.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseResponseModel.h"

@interface LogoutResponse : BaseResponseModel
@property(nonatomic,assign)int successCode;
@property(nonatomic,copy)NSString *errorMessage;
@property(nonatomic,assign)int errorCode;
@property(nonatomic,assign)int total;
@end
