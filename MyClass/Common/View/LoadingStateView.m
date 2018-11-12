//
//  LoadingStateView.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "LoadingStateView.h"
#import "HttpErrorMacro.h"
#import "CommonMacro.h"
#import "OneLoadingAnimationView.h"
#import "NSString+Size.h"
#import "Utils.h"
#import "GeneralDataCache.h"

typedef void(^ReloadHandle)(void);
@interface LoadingStateView() {
    OneLoadingAnimationView *loadingView;
    UILabel *errorLabel;
    UILabel *tipLabel;
    BOOL hasTouchMoved;
    int delayTime;
    UIControl *serviePhoneView;
    UIColor *textColor;
    NSString *telString;
    ReloadHandle reloadHandle;
}
@end
@implementation LoadingStateView

-(instancetype)initWithFrame:(CGRect)frame isLightStyle:(BOOL)isLightStyle {
    if (self = [super initWithFrame:frame]) {
        _isLightStyle = isLightStyle;
        delayTime = 1;
        textColor = BlueColor;
    }
    [self initViews];
    [self toLoadingState];
    return self;
}

- (void)initViews {
    loadingView = [[OneLoadingAnimationView alloc]initStyle:LargeStyle];
    if (_isLightStyle) {
        loadingView.normalColor = WhiteColor;
    } else {
        loadingView.normalColor = DarkGrayColor;
    }
    [loadingView setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - 56)];
    [self addSubview:loadingView];
    
    errorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, UIControlYLength(loadingView) + 10, UIViewWidth(self), 20)];
    [self addSubview:errorLabel];
    errorLabel.font = MediumFont;
    errorLabel.backgroundColor = [UIColor clearColor];
    errorLabel.textAlignment = NSTextAlignmentCenter;
    if (_isLightStyle) {
        errorLabel.textColor = [UIColor whiteColor];
    } else {
        errorLabel.textColor = DarkGrayColor;
    }
    errorLabel.layer.opacity = 0;
    
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, UIControlYLength(errorLabel) + 5, 180, 32)];
    [self addSubview:tipLabel];
    tipLabel.font = BigFont;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"点击重试";
    tipLabel.layer.opacity = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    hasTouchMoved = NO;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    hasTouchMoved = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!hasTouchMoved && reloadHandle && loadingView.state >= 2 ) {
        delayTime = 1.5;
        [self hideFailedMsg];
        [self toLoadingState];
        reloadHandle();
    }
}

- (void)hideFailedMsg {
    
}

- (void)toLoadingState {
    [loadingView startAnimation];
}

- (void)toEmptyState:(NSString *)emptyMsg {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [loadingView toEmptyViewState];
        [self showFailedViewWithCode:-1 errorMsg:emptyMsg];
    });
}

- (void)showFailedViewWithCode:(NSInteger)code errorMsg:(NSString *)message {
    CGFloat height = [message textSizeWithFont:errorLabel.font contrainedToSize:CGSizeMake(errorLabel.frame.size.width, 0)].height + 10 ;
    switch (code) {
        case CODE_NO_NETWORK:
            errorLabel.text = @"无网络连接，请打开网络连接";
            break;
        case CODE_CAN_NOT_CONNECT:
            errorLabel.text = @"连接超时，请稍后重试";
            break;
        case CODE_PARSH_FAILED:
        case CODE_CAN_NOT_FOUND_RESPONSE:
            errorLabel.text = @"数据获取失败，请重新获取";
            break;
        default:
            errorLabel.text = @"数据获取失败，请重新获取";
            break;
    }
    errorLabel.frame = CGRectMake(errorLabel.frame.origin.x, errorLabel.frame.origin.y, errorLabel.frame.size.width, height);
    tipLabel.frame = CGRectMake(errorLabel.frame.origin.x, UIControlYLength(errorLabel) + 8, errorLabel.frame.size.width , 32);
    [self showFailedMessageWithCode:code];
    delayTime = 1;
}

- (void)showFailedMessageWithCode:(NSInteger)code {
    [UIView animateWithDuration:1 animations:^{
        errorLabel.layer.opacity = 1;
        if (code != -1) {
            tipLabel.layer.opacity = 1;
        }
        if ([Utils isEmpty:[GeneralDataCache sharedGeneralDataCache].phoneNumber]) {
            [GeneralDataCache sharedGeneralDataCache].phoneNumber = @"请联系客服，打这个电话，只是电话目前还没有";
        }
    }];
}

- (void)toErrorStateWithErrorMsg:(NSInteger)code errorMsg:(NSString *)msg reloadHandle:(void (^)(void))reloadHandle {
    reloadHandle = reloadHandle;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [loadingView toFailedViewState];
        [self showFailedViewWithCode:code errorMsg:msg];
    });
}

- (void)removeSelf {
    if (self.superview) {
        [self removeFromSuperview];
    }
}

@end
