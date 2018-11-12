//
//  NSString+Size.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
- (CGSize)textSizeWithFont:(UIFont *)font contrainedToSize:(CGSize)size {
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [self sizeWithAttributes:attributes];
    } else {
        NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading ;
        NSDictionary *attrbutes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size options:option attributes:attrbutes context:nil];
        textSize = rect.size;
    }
    return textSize;
}

- (NSString *)subStringFromAppointString:(NSString *)appointString {
    NSString *resultString;
    if ([self rangeOfString:appointString].length >= 1) {
        NSRange range = [self rangeOfString:appointString];
        resultString = [self substringFromIndex:range.location];
        return resultString;
    }
    return nil;
}
@end
