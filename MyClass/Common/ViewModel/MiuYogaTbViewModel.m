//
//  MiuYogaTbViewModel.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "MiuYogaTbViewModel.h"

@implementation MiuYogaTbViewModel
- (void)initialize {
    [super initialize];
    self.currentPage = 1;
    self.totalPage = 10;
    
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *page) {
        @strongify(self)
        return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];
    
    // 过滤错误信息
    [[self.requestRemoteDataCommand.errors filter:[self requestRemoteDataErrorsFilter]]subscribe:self.errors];
}

- (BOOL(^)(NSError *error))requestRemoteDataErrorsFilter {
    return ^(NSError *error){
        return YES;
    };
}

- (id)fetchLoadData {
    return nil;
}

- (NSInteger)offsetForPage:(NSInteger)page {
    return (page - 1) * self.currentPage;;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSInteger)page {
    return [RACSignal empty];
}
@end
