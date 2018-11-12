//
//  AddressResponse.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/21.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseResponseModel.h"

@interface AddressData:BaseResponseModel
@property(nonatomic,assign)NSInteger defaultAddress;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *recipients;

@end

@protocol AddressData

@end
@interface AddressResponse : BaseResponseModel
@property(nonatomic,strong)NSArray<AddressData> * data;
@property(nonatomic,assign)int successCode;
@property(nonatomic,copy)NSString *errorMessage;
@property(nonatomic,assign)int errorCode;
@property(nonatomic,assign)int total;

@end
