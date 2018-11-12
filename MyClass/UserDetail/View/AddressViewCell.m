//
//  AddressViewCell.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/20.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "AddressViewCell.h"
#import "CommonMacro.h"
#import "UIView+SDAutoLayout.h"
@interface AddressViewCell(){
    UILabel *_city;
    UILabel *_contact; // 联系人
    UILabel *_mobile;
    UILabel  *_street; // 街道
    UIButton *_defaultDddress; // 默认地址
    UIButton *_edite; // 编辑
}
@end
@implementation AddressViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
    }
    return self;
}

- (void)createCell {
    _city = [[UILabel alloc] init];
    [self.contentView addSubview:_city];
    _city.textColor = BlackColor;
    _city.font = BoldBigFont;
    _city.frame = CGRectMake(20, 15, SCREEN_WIDTH - 40, 44);
    
    _contact = [[UILabel alloc] init];
    [self.contentView addSubview:_contact];
    _contact.textColor = LightGrayColor;
    _contact.font = SmallFont;
    _contact.sd_layout.leftEqualToView(_city).topSpaceToView(_city, 10).widthIs(60).heightIs(30);
    
    _mobile = [[UILabel alloc] init];
    [self.contentView addSubview:_mobile];
    _mobile.textColor = BlackColor;
    _mobile.font = BoldBigFont;
    _mobile.sd_layout.leftSpaceToView(_city, 20).topSpaceToView(_city, 10).widthIs(60).heightIs(30);
    
    _defaultDddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_defaultDddress];
    [_defaultDddress setTitle:@"默认地址" forState:UIControlStateNormal];
    _defaultDddress.sd_layout.leftEqualToView(_city).topSpaceToView(_contact, 20).widthIs(44).heightIs(34);
    
    _edite = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_edite];
    [_edite setTitle:@"编辑" forState:UIControlStateNormal];
    _edite.sd_layout.rightSpaceToView(self.contentView, 20).topSpaceToView(_contact, 20).widthIs(44).heightIs(34);
}

- (void)setCellValue:(AddressData *)addressData {
    _city.text = addressData.city;
    _mobile.text = addressData.mobile;
    _street.text = addressData.address;
    if (addressData.defaultAddress == 1) {
        [_defaultDddress setTitle:@"默认地址" forState:UIControlStateNormal];
    } else {
       [_defaultDddress setTitle:@"可选地址" forState:UIControlStateNormal];
    }
}
@end
