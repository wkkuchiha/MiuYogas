//
//  AppDelegate.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/2.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (IndexViewController *)createIndexViewControllerWithNeedLoadUserInfo:(BOOL)need;

@end

