//
//  URLHelper.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/7.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "URLHelper.h"
#import "Utils.h"

static NSString * miuyogaUrl = nil;
@implementation URLHelper
+ (void)setMiuyogaUrl:(NSString *)url {
    miuyogaUrl = url;
}

+ (NSString *)getMiuyogaUrl {
    if ([Utils isEmpty:miuyogaUrl]) {
        miuyogaUrl = @"https://www.baidu.com";
    }
    return miuyogaUrl;
}

+ (NSString *)getRequestURLWithMethod:(NSString *)methodName {
    NSMutableString * url = [[NSMutableString alloc]init];
    [url appendString:miuyogaUrl];
    [url appendString:methodName];
    return [url description];
}

@end
