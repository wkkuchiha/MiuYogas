//
//  NSDate+Format.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)
// 按照某种格式格式化日期
- (NSString *)formatWithStyle:(NSString *)style ;
@end
