//
//  PersonalDataViewCell.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/6.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalDataViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *nickname;
@property(nonatomic,strong)UILabel *userid;
@property(nonatomic,strong)UIButton *amendInfo;
@property(nonatomic,strong)UILabel *birthday;
@property(nonatomic,strong)UILabel *height;
@property(nonatomic,strong)UILabel *subtitle; // 我的宣言
@property(nonatomic,strong)UIButton *development; // 动态
@property(nonatomic,strong)UIButton *concern; //关注
@property(nonatomic,strong)UIButton *adorer; // 崇拜者
@property(nonatomic,strong)UIView *lineView; // 分割线

- (void)setViewValue:(NSString *)string;
@end
