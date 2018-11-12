//
//  CommunityViewCell.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "CommunityViewCell.h"
#import "UIView+CustomMethod.h"
@implementation CommunityViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 44, 44)];
    [self.contentView addSubview:_icon];

    _nickName = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentLeft backGroundColor:nil tintColor:nil textFont:SmallFont];
    [self.contentView addSubview:_nickName];
    _nickName.sd_layout.centerYEqualToView(_icon).leftSpaceToView(_icon, 10).widthIs(44).heightIs(34);
    
    _subject = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentLeft backGroundColor:nil tintColor:nil textFont:SmallFont];
    [self.contentView addSubview:_subject];
    _subject.sd_layout.leftEqualToView(_icon).topSpaceToView(_icon, 15).rightSpaceToView(self.contentView, 15).heightIs(44);
    
    _text = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentLeft backGroundColor:nil tintColor:nil textFont:SmallFont];
    [self.contentView addSubview:_text];
    _subject.sd_layout.leftEqualToView(_icon).topSpaceToView(_icon, 15).rightSpaceToView(self.contentView, 15).heightIs(44);
    
    
    _ikon = [BasicControlsUtil customImageView];
    [self.contentView addSubview:_ikon];
    
    _textView = [[UITextView alloc]init];
    [self.contentView addSubview:_textView];
    
    _praise = [BasicControlsUtil customBtnTextColor:[UIColor clearColor] backGroundColor:nil titleFont:SmallFont image:nil];
    [self.contentView addSubview:_praise];
    _praise.sd_layout.leftEqualToView(_icon).topSpaceToView(_textView, 10).widthIs(80).heightIs(34);
    
    _comment = [BasicControlsUtil customBtnTextColor:[UIColor clearColor] backGroundColor:nil titleFont:SmallFont image:nil];
    [self.contentView addSubview:_comment];
    _comment.frame = CGRectMake(SCREEN_WIDTH/2 - 40, UIControlYLength(_textView) + 10, 80, 34);
    
    _share = [BasicControlsUtil customBtnTextColor:[UIColor clearColor] backGroundColor:nil titleFont:SmallFont image:nil];
    [self.contentView addSubview:_share];
    _share.sd_layout.rightSpaceToView(self.contentView, 15).topEqualToView(_praise).widthIs(80).heightIs(34);
    
    _praiseIcon = [BasicControlsUtil customBtnTextColor:[UIColor clearColor] backGroundColor:nil titleFont:SmallFont image:nil];
    [self.contentView addSubview:_praiseIcon];
    
    _rightArrow = [BasicControlsUtil customImageView];
    [self.contentView addSubview:_rightArrow];
}
 
- (void)setTableCellData:(News *)dataSource bottomStyle:(BOOL)show{
    _icon.image = [UIImage imageNamed:dataSource.icon];
    _nickName.text = dataSource.nickname;
    _subject.text = dataSource.title;
    _ikon.image = [UIImage imageNamed:dataSource.picurl];
    
    if (show == YES) {
        [_praise setTitle:[NSString stringWithFormat:@"%d",dataSource.praise] forState:UIControlStateNormal];
        [_share setTitle:[NSString stringWithFormat:@"%d",dataSource.share] forState:UIControlStateNormal];
        _praiseIcon.hidden = YES;
        _rightArrow.hidden = YES;
        
    } else {
        _praise.hidden = YES;
        _share.hidden = YES;
        _praiseIcon.hidden = NO;
        
        UIView * customView = [self.contentView createLineWithColor:LineColor frame:CGRectZero];
        [self.contentView addSubview:customView];
        customView.sd_layout.leftEqualToView(_icon).rightSpaceToView(self.contentView, 15).topSpaceToView(_ikon, 10).heightIs(1);
        
        _share.sd_layout.topSpaceToView(customView, 4);
        
        _rightArrow.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(_share).widthIs(15).heightIs(15);
        
        _praiseIcon.sd_layout.leftSpaceToView(_share, 4).topSpaceToView(customView, 4).rightSpaceToView(_rightArrow, 4).heightIs(34);
    }
    
}
@end
