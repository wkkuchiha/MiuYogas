//
//  UIView+CustomMethod.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/6.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "UIView+CustomMethod.h"

@implementation UIView (CustomMethod)
- (UIView *)createLineWithColor:(UIColor *)color frame:(CGRect)frame {
    UIView * lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    return lineView;
}
@end
