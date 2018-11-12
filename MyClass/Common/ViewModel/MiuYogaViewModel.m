//
//  MiuYogaViewModel.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/27.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "MiuYogaViewModel.h"

@implementation MiuYogaViewModel

- (instancetype)initWithServices:(id<MiuViewModelServices>)services params:(NSDictionary *)params {
    if (self = [super init]) {
        _service = services;
        _params = params;
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    MiuYogaViewModel * viewModel = [super allocWithZone:zone];
    @weakify(viewModel);
    [[viewModel rac_signalForSelector:@selector(initWithServices:params:)] subscribeNext:^(id x) {
        @strongify(viewModel);
        [viewModel initialize];
    }];
    return viewModel;
}

- (void)initialize {
    
}

- (RACSubject *)errors {
    if (!_errors) {
        _errors = [RACSubject subject];
    }
    return _errors;
}

- (RACSubject *)willDisapperSignal {
    if (!_willDisapperSignal) {
        _willDisapperSignal = [RACSubject subject];
    }
    return _willDisapperSignal;
}
@end
