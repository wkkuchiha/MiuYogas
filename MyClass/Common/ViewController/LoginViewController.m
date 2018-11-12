//
//  LoginViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/4.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "LoginViewController.h"
#import "AwesomeTextField.h"
#import "UIView+SDAutoLayout.h"
#import "MDButton.h"
#import "CommonMacro.h"
#import "Utils.h"
#import "GeneralDataCache.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "GeneralDataCache.h"
#import "RequestManager.h"
#import "ViewHelper.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"
@interface LoginViewController ()<AwesomeTextFieldDelegate>{
    NSInteger pressCount;
    NSTimeInterval pressTime;
}
@property(nonatomic,strong)AwesomeTextField *username;
@property(nonatomic,strong)AwesomeTextField *password;
@property(nonatomic,strong)UILabel *logoTitle;
@property(nonatomic,strong)MDButton *loginBtn;
@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIButton *forgetBtn;
@property(nonatomic,strong)LoginInfo *info;

@end

@implementation LoginViewController

- (instancetype)init {
    if (self = [super init]) {
        pressTime = 0;
        pressCount = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self setupView];
}

- (void)setupView {
    _logoTitle = [[UILabel alloc]init];
    [self.view addSubview:_logoTitle];
    _logoTitle.frame = CGRectMake(SCREEN_WIDTH / 2 - 50 , 100, 100, 44);
    _logoTitle.textAlignment = NSTextAlignmentCenter;
    _logoTitle.text = @"用户登录";
    
    [self.view addSubview:self.username];
    [self.view addSubview:self.password];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.registerBtn];
    
    _username.frame = CGRectMake(SCREEN_WIDTH * 0.15, 200, SCREEN_WIDTH * 0.7, 64);
    _password.frame = CGRectMake(SCREEN_WIDTH * 0.15, UIControlYLength(_username) + 4, SCREEN_WIDTH * 0.7, 64);
    _loginBtn.frame = CGRectMake(SCREEN_WIDTH * 0.15, UIControlYLength(_password) + 10, SCREEN_WIDTH * 0.7, 44);
    _forgetBtn.frame = CGRectMake(SCREEN_WIDTH * 0.15, UIControlYLength(_loginBtn) + 10, SCREEN_WIDTH * 0.3, 44);
    _registerBtn.frame = CGRectMake(SCREEN_WIDTH * 0.5, UIControlYLength(_loginBtn) + 10, SCREEN_WIDTH * 0.3, 44);
    
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self login:x];
    }];
    
    [[_registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        RegisterViewController *registerCtrl = [RegisterViewController new];
        [self.navigationController pushViewController:registerCtrl animated:YES];
    }];
}

- (void)login:(UIButton *)sender {
    if (![self checkParms]) {
        return ;
    }
    [self clearkeyboard];
    LoginRequest *request = [LoginRequest new];
    [request setMobile:_username.text];
    [request setPassword:_password.text];
//    [GeneralDataCache sharedGeneralDataCache].accountName = _username.text;
//    [request setRememberdata:[NSNumber numberWithBool:YES]];
    [[RequestManager sharedRequestManager] sendRequest:request successed:^(BaseResponseModel *response) {
        LoginResponse * loginResponse = (LoginResponse *)response;
        _info = [loginResponse.data firstObject];
        GeneralDataCache *dataCache = [GeneralDataCache sharedGeneralDataCache];
        dataCache.authToken = _info.token ;
        [dataCache setLoginState:[NSNumber numberWithInt:1]];
        // 跳转到主页
        [self jumpToIndexViewController];
        
    } failed:^(int errorCode, NSString *errorMsg) {
        if (errorCode == 9) { // 忘记密码
            // 跳转到忘记密码
            NSLog(@"忘记密码");
        } else {
            NSString *msg = [Utils isEmpty:errorMsg]?@"登录失败":errorMsg;
            [ViewHelper showFailedHUDWithMessage:msg complition:nil];
        }
    }];
}

- (void)jumpToIndexViewController {
    NSMutableArray * views = [self.navigationController.viewControllers mutableCopy];
    for (UIViewController * viewController in self.navigationController.viewControllers) {
        if (![viewController isKindOfClass:[LoginViewController class]]) {
            [views removeObject:viewController];
        }
    }
    self.navigationController.viewControllers = views;
    [self.navigationController pushViewController:[AppDelegate createIndexViewControllerWithNeedLoadUserInfo:YES] animated:YES];
}

- (BOOL)checkParms {
    [self clearkeyboard];
    if (_username.text.length == 0) {
        _username.errorMsg = @"用户名";
        return NO;
    }
    if (_password.text.length == 0) {
        _password.errorMsg = @"密码";
        return NO;
    }
    return YES;
}

- (void)clearkeyboard {
    [_username.textField resignFirstResponder];
    [_password.textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (AwesomeTextField *)username {
    if (!_username) {
        _username = [[AwesomeTextField alloc]init];
        _username.placeholder = @"用户名";
        _username.tintColor = WhiteColor;
        _username.underlineColor = lightDarkColor;
        _username.underlineHighLightColor = LightBlueColor;
        _username.textColor = BlueColor;
        _username.delegate = self;
        NSString *username = [GeneralDataCache sharedGeneralDataCache].accountName;
        _username.text = [Utils isEmpty:username]?nil:username;
    }
    return _username;
}

- (AwesomeTextField *)password {
    if (!_password) {
        _password = [[AwesomeTextField alloc]init];
        _password.placeholder = @"密码";
        _password.tintColor = WhiteColor;
        _password.underlineColor = lightDarkColor;
        _password.textColor = BlueColor;
        _password.underlineHighLightColor = LightBlueColor;
        _password.delegate = self;
        [_password setSecureTextEntry:YES];
    }
    return _password;
}

- (MDButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[MDButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.7, 40) type:Raised rippleColor:BlueColor];
        _loginBtn.backgroundColor = WhiteColor;
        [_loginBtn.titleLabel setFont:BigFont];
        [_loginBtn setTitleColor:LightBlackColor forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登 陆" forState:UIControlStateNormal];
    }
    return _loginBtn;
}

- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn.titleLabel setFont:SmallFont];
        [_forgetBtn setTitleColor:BlueColor forState:UIControlStateNormal];
        [_forgetBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_forgetBtn setBackgroundColor:WhiteColor];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    }
    return _forgetBtn;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn.titleLabel setFont:SmallFont];
        [_registerBtn setTitleColor:BlueColor forState:UIControlStateNormal];
        [_registerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_registerBtn setTitle:@"用户注册" forState:UIControlStateNormal];
    }
    return _registerBtn;
}

@end
