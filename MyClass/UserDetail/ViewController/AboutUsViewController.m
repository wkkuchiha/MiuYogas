//
//  AboutUsViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/22.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "AboutUsViewController.h"
#import "BasicControlsUtil.h"
#import "CommonMacro.h"
@interface AboutUsViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation AboutUsViewController

- (instancetype)initWithUrl:(NSString *)requestUrl viewTitle:(NSString *)viewTitle {
    if (self = [super init]) {
        _requestUrl = requestUrl;
        _viewTitle = viewTitle;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settopView];
    [self setupView];
    [self loadGoogle];
}

- (void)settopView {
    UILabel *title = [BasicControlsUtil customLabelTextAlignment:NSTextAlignmentCenter backGroundColor:nil tintColor:[UIColor blackColor] textFont:BigFont];
    title.text = _viewTitle;
   
    self.navigationItem.titleView = title;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_nav_close"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackItem)];
}

- (void)clickBackItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupView {
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    _webView.delegate = self;
}

- (void)loadGoogle {
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_requestUrl]];
    [_webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"error:%@",error.description);
}
@end
