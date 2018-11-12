//
//  NewsDetailViewController.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

// 动态详情
#import "BaseUIViewController.h"
#import "NewsResponse.h"
@interface NewsDetailViewController : BaseUIViewController
@property(nonatomic,copy)NSString *userid;
- (instancetype)initWithData:(News *)dataSource;
@end
