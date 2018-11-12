//
//  NewsRequest.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseRequestModel.h"

@interface NewsRequest : BaseRequestModel
@property(nonatomic,copy)NSString *starttime;
@property(nonatomic,copy)NSString *endtime;
@property(nonatomic,assign)int status;
@end
