//
//  GeneralDataCache.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/2.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "GeneralDataCache.h"

@implementation GeneralDataCache
// 通过单利宏定义一个可变参数
SYNTHESIZE_SINGLETON_FOR_CLASS(GeneralDataCache);

- (void)setAuthToken:(NSString *)authToken {
    [[NSUserDefaults standardUserDefaults] setObject:authToken forKey:@"authToken"];
}

- (NSString *)authToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"authToken"];
}

- (void)setLoginState:(NSNumber *)loginState {
    [[NSUserDefaults standardUserDefaults] setObject:loginState forKey:@"loginState"];
}

- (NSNumber *)loginState {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"loginState"];
}

- (void)setAccountName:(NSString *)accountName {
    [[NSUserDefaults standardUserDefaults] setObject:accountName forKey:@"accountName"];
}

- (NSString *)accountName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"accountName"];
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    [[NSUserDefaults standardUserDefaults] setObject:phoneNumber forKey:@"phoneNumber"];
}

- (NSString *)phoneNumber {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
}
@end
