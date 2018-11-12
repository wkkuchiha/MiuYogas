//
//  LoadingStateView.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, LoadingStatesView) {
    STATE_LOADING = 1,
    STATE_ERROE = 2,
    STATE_EMPTY
};

@interface LoadingStateView : UIView

@property()BOOL isLightStyle ;
- (instancetype)initWithFrame:(CGRect)frame isLightStyle:(BOOL)isLightStyle;
- (void)toLoadingState;
- (void)toEmptyState:(NSString *)emptyMsg;
- (void)toErrorStateWithErrorMsg:(NSInteger)code errorMsg:(NSString *)msg reloadHandle:(void(^)(void))reloadHandle;
- (void)removeSelf;
@end
