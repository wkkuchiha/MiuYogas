//
//  PersonalDataViewCell.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/6.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "PersonalDataViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "CommonMacro.h"
#import "UIView+CustomMethod.h"
@implementation PersonalDataViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    _icon = [[UIImageView alloc]init];
    [self.contentView addSubview:_icon];
    _icon.sd_layout.leftSpaceToView(self.contentView, 20).centerYEqualToView(self.contentView).widthIs(44).heightIs(44);
    
    _nickname = [[UILabel alloc]init];
    [self.contentView addSubview:_nickname];
    _nickname.sd_layout.leftSpaceToView(_icon, 10).topEqualToView(_icon).widthIs(200).heightIs(44);
    
    _userid = [[UILabel alloc]init];
    [self.contentView addSubview:_userid];
    _userid.sd_layout.leftEqualToView(_nickname).topSpaceToView(_nickname, 10).widthIs(200).heightIs(24);
    
    _amendInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_amendInfo];
    _amendInfo.sd_layout.leftEqualToView(_nickname).rightSpaceToView(self.contentView, 30).bottomEqualToView(_icon).heightIs(44);
    
    _birthday = [[UILabel alloc]init];
    [self.contentView addSubview:_birthday];
    _birthday.sd_layout.leftEqualToView(_icon).topSpaceToView(_icon, 10).widthIs(100).heightIs(24);
    
    _height = [[UILabel alloc]init];
    [self.contentView addSubview:_height];
    _height.sd_layout.leftSpaceToView(_birthday, 10).topEqualToView(_birthday).widthIs(100).heightIs(24);
    
    _subtitle = [[UILabel alloc]init];
    [self.contentView addSubview:_subtitle];
    _subtitle.sd_layout.leftEqualToView(_nickname).topEqualToView(_birthday).rightEqualToView(_amendInfo).heightIs(24);
    
    UIView * customView = [self.contentView createLineWithColor:LineColor frame:CGRectZero];
    [self.contentView addSubview:customView];
    customView.sd_layout.leftEqualToView(_icon).rightEqualToView(_amendInfo).topSpaceToView(_birthday, 10).heightIs(1);
    
    _development = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_development];
    _development.frame = CGRectMake(SCREEN_WIDTH / 6, UIControlYLength(customView) + 10, 10, 24);
    
    _concern = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_concern];
    _concern.sd_layout.centerXEqualToView(self.contentView).topEqualToView(_development).widthIs(10).heightIs(24);
    
    _adorer = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_adorer];
    _adorer.sd_layout.rightSpaceToView(self.contentView, SCREEN_WIDTH/6).topEqualToView(_development).widthIs(10).heightIs(44);
}

- (void)setViewValue:(NSString *)string {
    _height.text = string;
}
@end
