//
//  BaseRequestModel.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/2.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseRequestModel.h"
#import <objc/runtime.h>
#import "GeneralDataCache.h"
#import "NSDate+Format.h"
#import "CommonMacro.h"
#import "Utils.h"
#import "URLHelper.h"


@implementation BaseRequestModel

+ (BOOL)propertyIsIgnored:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"retriesCount"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

- (BaseRequestModel *)initWidthBusinessMethodName:(NSString *)methodName ver:(NSString *)version
{
    return self;
}

static GeneralDataCache * extracted() {
    return [GeneralDataCache sharedGeneralDataCache];
}

- (instancetype)init

{
    self = [super init];
    if (self) {
        _processTime = [[Utils now] formatWithStyle:DATEFORMAT_YMD_HMS];
        _deviceId = DeviceUUID;
        _authTkn = extracted().authToken;
        _retriesCount = 0;
    }
    return self;
}

- (NSString *)getMethodName
{
    return @"";
}

//请求的URL
- (NSString *)getRequestURL {
    return [URLHelper getRequestURLWithMethod:[self getMethodName]];
}

@end
