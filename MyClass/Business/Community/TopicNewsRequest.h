//
//  TopicNewsRequest.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseRequestModel.h"
#import "MiuYogaApi.h"

@interface TopicNewsRequest : BaseRequestModel
@property(nonatomic,weak)NSNumber *type;
@property(nonatomic,copy)NSString *starttime;
@property(nonatomic,copy)NSString *endtime;
@property(nonatomic,assign)int status;
@end
