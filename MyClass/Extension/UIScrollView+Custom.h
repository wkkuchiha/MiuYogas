//
//  UIScrollView+Custom.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Custom)<UIScrollViewDelegate>
+ (UIScrollView *)initWithScrollFrame:(CGRect)frame imgaCount:(NSInteger)count imgaDataSource:(NSArray *)dataSource;
@end
