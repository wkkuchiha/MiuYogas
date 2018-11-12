//
//  Utils.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "Utils.h"
#import "NSString+Checker.h"

@implementation Utils

+ (NSDate *)now {
    NSDate * date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger integer = [zone secondsFromGMTForDate:date];
    return [date dateByAddingTimeInterval:integer];
}

+ (id)parshJsonString:(NSString *)json {
    if ([Utils isEmpty:json]) {
        return NULL;
    }
    NSError *error;
    id data = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    return data;
}

+ (BOOL)isEmpty:(NSObject *)object {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([object isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)object;
        return [string isEmptyString];
    }
    return NO;
}

@end
