//
//  NSString+Checker.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "NSString+Checker.h"
#import "Utils.h"
@implementation NSString (Checker)
- (BOOL)isEmptyString {
    if ([self isKindOfClass:[NSNull class]] || self.length == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isPhoneNumberOrTelNumber
{
    if ([Utils isEmpty:self]) {
        return NO;
    }
    
    NSString *phoneNumRegex = @"(\\+\\d+)?1[345678]\\d{9}$";
    NSString *telRegex = @"^[0-9 -]+$"; //@"^(0[0-9]{2,3}\\-)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", phoneNumRegex];
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", telRegex];
    BOOL isPhone = [phoneTest evaluateWithObject:self];
    BOOL isTel = [telTest evaluateWithObject:self];
    if (isPhone || isTel) {
        return YES;
    }
    return NO;
}

- (BOOL)isIncludeSpecialCharact
{
    NSRange urgentRange = [self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€，,.。？‘’：；:;''=\\"]];
    if (urgentRange.location == NSNotFound) {
        return NO;
    }
    return YES;
}
@end
