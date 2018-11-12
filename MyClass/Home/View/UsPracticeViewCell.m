//
//  UsPracticeViewCell.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "UsPracticeViewCell.h"
#import "BasicControlsUtil.h"
#import "CommonMacro.h"
#import "UIView+SDAutoLayout.h"
#import "UsPracticeViewModel.h"

@interface UsPracticeViewCell()
@property(nonatomic,strong)UsPractice *viewModel;
@end

@implementation UsPracticeViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _title = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentLeft backGroundColor:nil tintColor:nil textFont:SmallFont];
    [self.contentView addSubview:_title];
    
    _message = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentCenter backGroundColor:nil tintColor:nil textFont:SmallFont];
    [self.contentView addSubview:_message];
    
    _count = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentRight backGroundColor:nil tintColor:nil textFont:SmallFont];
    [self.contentView addSubview:_count];
    
    _title.frame = CGRectMake(10, 10, 80, 34);
    _message.frame = CGRectMake(10, UIControlYLength(_title) + 4, 80, 34);
    _count.sd_layout.rightSpaceToView(self.contentView, 10).topEqualToView(_title).widthIs(80).heightIs(34);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cellId";
    UsPracticeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UsPracticeViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)bindViewModel:(UsPractice *)viewModel {
    self.viewModel = viewModel;
    self.title.text = viewModel.title;
    self.message.text = viewModel.message;
    self.count.text = viewModel.count;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
