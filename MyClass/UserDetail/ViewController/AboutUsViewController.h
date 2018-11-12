//
//  AboutUsViewController.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/22.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "BaseUIViewController.h"

@interface AboutUsViewController : BaseUIViewController
@property(nonatomic,copy)NSString *viewTitle;
@property(nonatomic,copy)NSString *requestUrl;
- (instancetype)initWithUrl:(NSString *)requestUrl viewTitle:(NSString *)viewTitle;
@end
