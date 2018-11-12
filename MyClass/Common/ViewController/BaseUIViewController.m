//
//  BaseUIViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseUIViewController.h"
#import "CommonMacro.h"
#import "RequestManager.h"
#import "HttpErrorMacro.h"
 
typedef enum {
    LightStyle,
    GrayStyle
}IndicatorStyle;

@interface BaseUIViewController ()

@end

@implementation BaseUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
}



@end
