//
//  AddStreetRequest.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/20.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseRequestModel.h"

@interface AddStreetRequest : BaseRequestModel
@property(nonatomic,copy)NSString *contact;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *street;
@end


