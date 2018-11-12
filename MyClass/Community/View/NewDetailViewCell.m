//
//  NewDetailViewCell.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "NewDetailViewCell.h"
#import "UIView+CustomMethod.h"
#import "BasicControlsUtil.h"
#import "CommonMacro.h"
#import "UIView+SDAutoLayout.h"

@implementation NewDetailViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _commentCount = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentLeft backGroundColor:lightDarkColor tintColor:nil textFont:SmallFont];
    [self.contentView addSubview:_commentCount];
    _commentCount.frame = CGRectMake(15,10, 100, 24);
    
    UIView * customView = [self.contentView createLineWithColor:LineColor frame:CGRectMake(15, UIControlYLength(_commentCount) + 3, SCREEN_WIDTH - 30, 1)];
    [self.contentView addSubview:customView];
    
    _icon = [BasicControlsUtil customImageView];
    [self.contentView addSubview:_icon];
    _icon.sd_layout.leftEqualToView(_commentCount).topSpaceToView(customView, 15).widthIs(44).heightIs(44);
    
    _nickName = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentLeft backGroundColor:nil tintColor:nil textFont:SmallFont];
    [self.contentView addSubview:_nickName];
    _nickName.sd_layout.leftEqualToView(_commentCount).centerYEqualToView(_icon).widthIs(44).heightIs(44);
    
    _intervalTime = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentLeft backGroundColor:nil tintColor:nil textFont:SmallFont];
    [self.contentView addSubview:_intervalTime];
    _intervalTime.sd_layout.leftSpaceToView(_nickName, 15).centerYEqualToView(_nickName).widthIs(64).heightIs(24);
    
    _text = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentLeft backGroundColor:nil tintColor:nil textFont:SmallFont];
    [self.contentView addSubview:_text];
    
    _praise = [BasicControlsUtil customBtnTextColor:nil backGroundColor:nil titleFont:SmallFont image:nil];
    [self.contentView addSubview:_praise];
    _praise.sd_layout.rightSpaceToView(self.contentView, 15).topEqualToView(_nickName).widthIs(24).heightIs(24);
}

- (void)setNewsDetailData:(NewsDetail *)dataSource {
    _commentCount.text = [NSString stringWithFormat:@"%@",dataSource.commentCout];
    _icon.image = [UIImage imageNamed:dataSource.icon];
    _nickName.text = dataSource.nickName;
    _intervalTime.text = dataSource.intervalTime;
    _text.text = dataSource.text;
}
@end

