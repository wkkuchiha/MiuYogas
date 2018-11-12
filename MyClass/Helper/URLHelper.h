//
//  URLHelper.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/7.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLHelper : NSObject
+ (void)setMiuyogaUrl:(NSString *)url ;
+ (NSString *)getMiuyogaUrl;
+ (NSString *)getRequestURLWithMethod:(NSString *)methodName;
@end
