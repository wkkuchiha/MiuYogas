//
//  Utils.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
+ (NSDate *)now;
+ (id)parshJsonString:(NSString *)json;
+ (BOOL)isEmpty:(NSObject *)object;
 
@end
