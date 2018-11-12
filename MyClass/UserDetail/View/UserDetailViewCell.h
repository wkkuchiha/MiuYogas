//
//  UserDetailViewCell.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/5.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UIImageView *arrow;

- (void)setValueWithView:(NSString *)icon title:(NSString *)title ;
@end

@interface UserDetail:UITableViewCell
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *nickname;
@property(nonatomic,strong)UILabel *subtitle;
@property(nonatomic,strong)UIImageView *arrow;

- (void)setValueWithView:(NSString *)icon nickname:(NSString *)nickname subtitle:(NSString *)title ;
@end
