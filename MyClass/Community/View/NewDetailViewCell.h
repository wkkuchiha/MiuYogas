//
//  NewDetailViewCell.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/11.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailResponse.h"

@interface NewDetailViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *commentCount; // 总计评论数
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *intervalTime; // 间隔时间
@property(nonatomic,strong)UILabel *text; // 评论的正文
@property(nonatomic,strong)UIButton *praise; // 点赞

- (void)setNewsDetailData:(NewsDetail *)dataSource;
@end
