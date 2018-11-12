//
//  UIScrollView+Custom.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "UIScrollView+Custom.h"
#import "CommonMacro.h"

@implementation UIScrollView (Custom)

+ (UIScrollView *)initWithScrollFrame:(CGRect)frame imgaCount:(NSInteger)count imgaDataSource:(NSArray *)dataSource{
    CGFloat viewW = frame.size.width;
    CGFloat viewH = frame.size.height;
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:frame];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.pagingEnabled = YES;
    scroll.contentSize = CGSizeMake(viewW * count, 0);
    
    for (int i = 0 ; i < count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(viewW * count, 0, viewW, viewH)];
        imgView.image = [UIImage imageNamed:[dataSource objectAtIndex:i]];
        [scroll addSubview:imgView];
    }
    return scroll;
}
@end
