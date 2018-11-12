//
//  CommunityViewCell.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SDAutoLayout.h"
#import "BasicControlsUtil.h"
#import "CommonMacro.h"
#import "NSString+Size.h"
#import "NewsResponse.h"

@interface CommunityViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *subject; // 标题
@property(nonatomic,strong)UILabel *text; // 正文
@property(nonatomic,strong)UIImageView *ikon; // 插画
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *praise; // 点赞
@property(nonatomic,strong)UIButton *comment; // 评论
@property(nonatomic,strong)UIButton *share; // 分享
@property(nonatomic,strong)UIButton *praiseIcon; // 点赞了的人的头像
@property(nonatomic,strong)UIImageView *rightArrow;

- (void)setTableCellData:(News *)dataSource bottomStyle:(BOOL)show;
@end
