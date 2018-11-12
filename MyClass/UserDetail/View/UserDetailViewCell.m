//
//  UserDetailViewCell.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/5.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "UserDetailViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "CommonMacro.h"

@implementation UserDetailViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView {
    _icon = [[UIImageView alloc]init];
    [self.contentView addSubview:_icon];
    _icon.sd_layout.leftSpaceToView(self.contentView, 20).centerYEqualToView(self.contentView).widthIs(24).heightIs(24);
    
    _title = [[UILabel alloc]init];
    [self.contentView addSubview:_title];
    _title.sd_layout.leftSpaceToView(_icon, 10).centerYEqualToView(self.contentView).widthIs(200).heightIs(44);
    
    _arrow = [[UIImageView alloc]init];
    [self.contentView addSubview:_arrow];
    _arrow.sd_layout.rightSpaceToView(self.contentView, 20).centerYEqualToView(self.contentView).widthIs(24).heightIs(24);
    _arrow.image = [UIImage imageNamed:@"arrow"];
}

- (void)setValueWithView:(NSString *)icon title:(NSString *)title {
    _icon.image = [UIImage imageNamed:icon];
    _title.text = title;
}
@end


@implementation UserDetail
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView {
    _icon = [[UIImageView alloc]init];
    [self.contentView addSubview:_icon];
    _icon.sd_layout.leftSpaceToView(self.contentView, 20).centerYEqualToView(self.contentView).widthIs(44).heightIs(44);
    
    _nickname = [[UILabel alloc]init];
    [self.contentView addSubview:_nickname];
    _nickname.sd_layout.leftSpaceToView(_icon, 10).topSpaceToView(self.contentView, 10).widthIs(200).heightIs(44);
    _nickname.font = [UIFont systemFontOfSize:22];
    
    _subtitle = [[UILabel alloc]init];
    [self.contentView addSubview:_subtitle];
    _subtitle.sd_layout.leftEqualToView(_nickname).bottomSpaceToView(self.contentView, 10).widthIs(200).heightIs(24);
     _subtitle.font = MediumFont;
    _subtitle.textColor = grayDarkColor;
    
    _arrow = [[UIImageView alloc]init];
    [self.contentView addSubview:_arrow];
    _arrow.sd_layout.rightSpaceToView(self.contentView, 20).centerYEqualToView(self.contentView).widthIs(24).heightIs(24);
    _arrow.image = [UIImage imageNamed:@"arrow"];
}

- (void)setValueWithView:(NSString *)icon nickname:(NSString *)nickname subtitle:(NSString *)title {
    _icon.image = [UIImage imageNamed:icon];
    _nickname.text = nickname;
    _subtitle.text = title;
}
@end
