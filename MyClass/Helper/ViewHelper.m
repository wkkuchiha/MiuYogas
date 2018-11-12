//
//  ViewHelper.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/5.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "ViewHelper.h"
#import "CommonMacro.h"
#import "NSString+Size.h"
#import "UITouchToolBar.h"
#import "AppDelegate.h"
#import "LoadingHUD.h"
#import "OneLoadingAnimationView.h"
@implementation ViewHelper
+ (void)showPromptText:(NSString *)text {
    if (!text || text.length == 0) {
        return ;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate ;
    UIView *currentView = appDelegate.window;
    for (UIView *view in currentView.subviews) {
        if ([view isKindOfClass:[UITouchToolBar class]]) {
            [view removeFromSuperview];
        }
    }
    CGFloat minWidth = SCREEN_WIDTH / 2;
    CGFloat maxWidth = SCREEN_WIDTH - 60;
    CGFloat width = [text textSizeWithFont:[UIFont systemFontOfSize:15] contrainedToSize:CGSizeMake(0, 40)].width + 20;
    if (width < minWidth) {
        width = minWidth;
    } else if (width > maxWidth) {
        width = maxWidth;
    }
    CGFloat height = [text textSizeWithFont:[UIFont systemFontOfSize:15] contrainedToSize:CGSizeMake(width - 10, 0)].height + 10;
    if (height < 40) {
        height = 40;
    }
    UITouchToolBar *toolBar = [[UITouchToolBar alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - width) / 2, SCREENH_HEIGHT /2 - 20, width, height)];
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.layer.cornerRadius = 5;
    toolBar.layer.masksToBounds = YES;
    [currentView addSubview:toolBar];
    
    UILabel *toolLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 4, width - 10, height - 8)];
    toolLabel.textColor = WhiteColor;
    toolLabel.font = [UIFont systemFontOfSize:15];
    toolLabel.textAlignment = NSTextAlignmentCenter;
    [toolBar addSubview:toolLabel];
    toolLabel.text = text;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:2.5];
        // 回调到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [toolBar removeFromSuperview];
        });
    });
}

+ (void)showBottomPromptText:(NSString *)text {
    
}

+ (void)showBottomPromptText:(NSString *)text duration:(NSTimeInterval)duration {
    [self showBottomPromptText:text];
}

+ (void)showSuccessHUDWithComplition:(void (^)(void))complition {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView * view = appDelegate.window;
    LoadingHUD *loading = [LoadingHUD HUDForView:view];
    UIView * customView = loading.customView;
    if (customView && customView.subviews.count > 0) {
        OneLoadingAnimationView * loadingView = (OneLoadingAnimationView *)customView.subviews.firstObject;
        [loadingView toSuccessViewState];
        loadingView.loadingAnimFinishedHandler = ^{
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC );
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [loading hideHUDAnimated:YES];
                if (complition) {
                    complition();
                }
            });
        };
    }
}

+ (void)hideHUDWithComplition:(void (^)(void))complition {
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView * view = appDelegate.window;
    LoadingHUD *loading = [LoadingHUD HUDForView:view];
    [loading hideHUDAnimated:YES];
    if (complition) {
        complition();
    }
}
    

+ (void)showFailedHUDWithMessage:(NSString *)msg complition:(void (^)(void))complition {
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView * view = appDelegate.window;
    LoadingHUD *loading = [LoadingHUD HUDForView:view];
    UIView * customView = [loading customView];
    if (customView && view.subviews.count > 0 ) {
        OneLoadingAnimationView * loadingView = (OneLoadingAnimationView *)customView.subviews.firstObject;
        [loadingView toFailedViewState];
        loadingView.loadingAnimFinishedHandler = ^{
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW , 0.3 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [loading hideHUDAnimated:YES];
            });
        };
    }
}
@end
