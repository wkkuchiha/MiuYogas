//
//  GeneralDataCache.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/2.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCSingletonTemplate.h"
 

@interface GeneralDataCache : NSObject

SYNTHESIZE_SINGLETON_FOR_HEADER(GeneralDataCache);
@property(nonatomic,copy)NSString * authToken;
@property(nonatomic,copy)NSString * accountName;
@property(nonatomic,assign)NSNumber * loginState;
@property(nonatomic,copy)NSString *phoneNumber;

// 读取用户信息
- (void)reloadUserInfoFormDataCache;
@end
