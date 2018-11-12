//
//  UITouchToolBar.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/5.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "UITouchToolBar.h"

@implementation UITouchToolBar

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }
}

@end
