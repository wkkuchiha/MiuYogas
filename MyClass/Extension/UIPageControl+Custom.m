//
//  UIPageControl+Custom.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "UIPageControl+Custom.h"
#import "CommonMacro.h"
@implementation UIPageControl (Custom)
+ (UIPageControl *)initWithPageCtrlFrame:(CGRect)frame pageCount:(NSInteger)count {
    
    CGFloat viewW = frame.size.width;
    CGFloat viewH = frame.size.height;
    UIPageControl *pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(viewW - 100, viewH - 40, 40, 10)];
    pageCtrl.numberOfPages = count;
    pageCtrl.currentPage = 0;
    pageCtrl.currentPageIndicatorTintColor = WhiteColor;
    pageCtrl.pageIndicatorTintColor = [UIColor colorWithWhite:0.8 alpha:0.4];
    return pageCtrl;
}
@end
