//
//  NSString+Size.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)
- (CGSize)textSizeWithFont:(UIFont *)font contrainedToSize:(CGSize)size ;
- (NSString *)subStringFromAppointString:(NSString *)appointString;
@end
