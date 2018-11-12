//
//  LogoutRequest.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/19.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "LogoutRequest.h"
#import "MiuYogaApi.h"

@implementation LogoutRequest
- (NSString *)getMethodName {
    return api_account_logout;
}
@end
