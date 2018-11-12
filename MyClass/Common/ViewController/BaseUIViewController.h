//
//  BaseUIViewController.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseUIViewController : UIViewController
// 键盘弹出和消失的事件
- (void)keyBoardShow:(CGRect *)frame animationDuration:(NSTimeInterval)duration;
- (void)keyBoardHide:(CGRect *)frame animationDuration:(NSTimeInterval)duration;
@end
