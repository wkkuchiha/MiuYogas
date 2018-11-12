//
//  MiuViewController.h
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

// 定义自定义视图的基类
#import <UIKit/UIKit.h>
#import "MiuYogaTbViewModel.h"
@interface MiuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,strong)MiuYogaTbViewModel *viewModel;
// tableView 的内容缩进，default is UIEdgeInsetsMake(64,0,0,0)，you can override it
@property (nonatomic, assign) UIEdgeInsets contentInset;
@property(nonatomic,copy)NSArray *dataSource;

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
- (instancetype)initWithViewModel:(MiuYogaViewModel *)viewModel;
- (void)reloadData;
// 绑定数据模型
- (void)bindViewModel;
 
@end
