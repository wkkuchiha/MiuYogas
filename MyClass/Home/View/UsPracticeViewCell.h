//
//  UsPracticeViewCell.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiuReactiveView.h"
@interface UsPracticeViewCell : UITableViewCell<MiuReactiveView>
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *message;
@property(nonatomic,strong)UILabel *count;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
