//
//  NSDate+Format.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)

- (NSString *)formatWithStyle:(NSString *)style {
    if (!self) {
        return nil;
    }
    NSDateFormatter * dateFormate = [[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:style];
    NSTimeZone * GTMZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormate setTimeZone:GTMZone];
    NSString * string = [dateFormate stringFromDate:self];
    return string;
}
@end
