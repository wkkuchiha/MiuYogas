//
//  Logger.h
//  MiuTrip
//
//  Created by Miutrip on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject

+(void)log:(NSString*)string;

+(void)log:(NSString*)tag string:(NSString*)value;
//截取字符串，最大1024
+(void)log:(NSString*)tag shortString:(NSString*)value;

+(void)log:(NSString*)tag integer:(NSInteger)value;

+(void)log:(NSString*)tag float:(float)value;


@end
