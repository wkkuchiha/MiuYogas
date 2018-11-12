//
//  ViewHelper.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/5.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewHelper : NSObject
// 在屏幕中央显示黑色背景的消息提示
+ (void)showPromptText:(NSString *)text ;
// 在屏幕下方显示黑色背景的消息提示
+ (void)showBottomPromptText:(NSString *)text;
// 在屏幕下方显示黑色背景的消息提示
+ (void)showBottomPromptText:(NSString *)text duration:(NSTimeInterval)duration;
// 数据加载成功的动画
+ (void)showSuccessHUDWithComplition:(void(^)(void))complition;
+ (void)hideHUDWithComplition:(void (^)(void))complition;
+ (void)showFailedHUDWithMessage:(NSString *)msg complition:(void(^)(void))complition;
@end
