//
//  ForgetInfoViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/8.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "ForgetInfoViewController.h"
#import "AwesomeTextField.h"
#import "MDButton.h"
#import "CommonMacro.h"
#import "HttpErrorMacro.h"
#import "Utils.h"
#import "GeneralDataCache.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RegisterRequest.h"
#import "RegisterResponse.h"
#import "RequestManager.h"
@interface ForgetInfoViewController ()<AwesomeTextFieldDelegate>
@property(nonatomic,strong)AwesomeTextField *username;
@property(nonatomic,strong)MDButton *registerBtn;
@property(nonatomic,strong)UILabel *forgetInfoLabel;
@property(nonatomic,strong)AwesomeTextField *password;
@property(nonatomic,strong)AwesomeTextField *mobile;
@property(nonatomic,strong)UserRegister *userinfo;


@end

@implementation ForgetInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    _forgetInfoLabel = [[UILabel alloc]init];
    _forgetInfoLabel.frame = CGRectMake(SCREEN_WIDTH / 2 - 50 , 100, 100, 44);
    _forgetInfoLabel.textAlignment = NSTextAlignmentCenter;
    _forgetInfoLabel.text = @"忘记密码";
    
    [self.view addSubview:_forgetInfoLabel];
    [self.view addSubview:self.username];
    [self.view addSubview:self.password];
    [self.view addSubview:self.mobile];
    [self.view addSubview:self.registerBtn];
    
    _username.frame = CGRectMake(SCREEN_WIDTH * 0.15, 200, SCREEN_WIDTH * 0.7, 64);
    _password.frame = CGRectMake(SCREEN_WIDTH * 0.15, UIControlYLength(_username) + 4, SCREEN_WIDTH * 0.7, 64);
    _mobile.frame = CGRectMake(SCREEN_WIDTH * 0.15, UIControlYLength(_password) + 4, SCREEN_WIDTH * 0.7, 64);
    _registerBtn.frame = CGRectMake(SCREEN_WIDTH * 0.15, UIControlYLength(_mobile) + 10, SCREEN_WIDTH * 0.7, 44);
    [[_registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        // 调用用户注册接口
        [self userRegistration];
    }];
}

- (void)userRegistration {
    RegisterRequest *request = [RegisterRequest new];
  //  request.username = _username.textField.text;
    request.password = _password.textField.text;
    request.mobile = _mobile.textField.text;
    
    [[RequestManager sharedRequestManager] sendRequest:request successed:^(BaseResponseModel *response) {
        RegisterResponse * registerResponse = (RegisterResponse *)response;
        _userinfo = [registerResponse.data firstObject];
        GeneralDataCache *cache = [GeneralDataCache sharedGeneralDataCache];
        cache.accountName = _userinfo.username;
        cache.authToken = _userinfo.token;
    } failed:^(int errorCode, NSString *errorMsg) {
        LRLog(@"------ errorCode:%d , errorMsg:%@",errorCode,errorMsg);
    }];
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
        _password.underlineHighLightColor = LightBlueColor;
        _password.textColor = BlueColor;
        _password.delegate = self;
        [_password setSecureTextEntry:YES];
    }
    return _password;
}

- (AwesomeTextField *)mobile {
    if (!_mobile) {
        _mobile = [[AwesomeTextField alloc]init];
        _mobile.placeholder = @"电话号码";
        _mobile.tintColor = WhiteColor;
        _mobile.underlineColor = lightDarkColor;
        _mobile.underlineHighLightColor = LightBlueColor;
        _mobile.textColor = BlueColor;
        _mobile.delegate = self;
    }
    return _mobile;
}

- (MDButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [[MDButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.6, 40) type:Raised rippleColor:BlueColor];
        //        _registerBtn.backgroundColor = WhiteColor;
        [_registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
    }
    return _registerBtn;
}

@end

