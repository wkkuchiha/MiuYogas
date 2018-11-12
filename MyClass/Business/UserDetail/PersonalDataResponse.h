//
//  PersonalDataResponse.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/6.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseResponseModel.h"

@interface PersonalData:BaseResponseModel
@property(nonatomic,copy)NSNumber *userid;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,copy)NSNumber *height;
@property(nonatomic,copy)NSString *declaration;
@property(nonatomic,assign)NSNumber *action;
@property(nonatomic,copy)NSNumber *concern;
@property(nonatomic,copy)NSNumber *adorer;
@end

@protocol PersonalData

@end

 
@interface PersonalDataResponse : BaseResponseModel
@property(nonatomic,strong)NSArray<PersonalData> * data;
@property(nonatomic,assign)int successCode;
@property(nonatomic,copy)NSString *errorMessage;
@property(nonatomic,assign)int errorCode;
@property(nonatomic,assign)int total;
@end


