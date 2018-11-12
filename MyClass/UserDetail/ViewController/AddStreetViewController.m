//
//  AddStreetViewController.m
//  MiuYoga
//
//  Created by uchiha on 2018/3/20.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "AddStreetViewController.h"
#import "AwesomeTextField.h"
#import "MDButton.h"
#import "CommonMacro.h"
#import "UIView+CustomMethod.h"
#import "UIView+SDAutoLayout.h"
#import "AddStreetResponse.h"
#import "AddStreetRequest.h"
#import "RequestManager.h"
#import "ViewHelper.h"
#import "Utils.h"
#import "NSString+Checker.h"
@interface AddStreetViewController ()<AwesomeTextFieldDelegate> {
    UIScrollView                *_contentView;
    AwesomeTextField            *_contact; // 联系人
    AwesomeTextField            *_mobile;
    AwesomeTextField            *_city;
    AwesomeTextField            *_street; // 街道
    MDButton                    *_saveBtn; // 确定
}
@end

@implementation AddStreetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavTitle];
    [self setBackBtn];
    [self setupView];
}

- (void)addNavTitle {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"联系信息";
    title.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = title;
}

- (void)setBackBtn {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_nav_close"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackItem)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)clickBackItem {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupView {
    [self.view addSubview:self.contentView];
    [self updateViewConstraints];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    _contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
    _contact.frame = CGRectMake(16, 16, SCREEN_WIDTH - 32, 64);
    _mobile.frame = CGRectMake(16, UIControlYLength(_contact) + 2, SCREEN_WIDTH - 32, 64);
    _city.frame = CGRectMake(16, UIControlYLength(_mobile) + 2, SCREEN_WIDTH - 32, 64);
    _street.frame = CGRectMake(16, UIControlYLength(_city) + 2, SCREEN_WIDTH - 32, 64);
    _saveBtn.frame = CGRectMake(16, UIControlYLength(_street) + 60, SCREEN_WIDTH - 32, 64);
}

#pragma mark - init views
- (UIScrollView *)contentView {
    if(!_contentView){
        _contentView = [[UIScrollView alloc] init];
        _contentView.backgroundColor = HeaderFooterViewColor;
        
        [_contentView addSubview:self.contact];
        [_contentView addSubview:self.mobile];
        [_contentView addSubview:self.city];
        [_contentView addSubview:self.street];
        [_contentView addSubview:self.saveBtn];
    }
    return _contentView;
}

- (AwesomeTextField *)contact
{
    if (!_contact) {
        _contact = [[AwesomeTextField alloc] init];
        _contact.underlineHighLightColor = BlueColor;
        _contact.underlineWidth = 1;
        _contact.placeholderColor = GrayColor;
        _contact.placeholder = @"联系人";
        _contact.textColor = LightBlackColor;
        _contact.font = [UIFont systemFontOfSize:16];
        _contact.text = @"龙凤呈祥";
        _contact.delegate = self;
        _contact.maxCharacterNumber = 20;
        _contact.showCharacterNumber = YES;
    }
    return _contact;
}

- (AwesomeTextField *)mobile
{
    if (!_mobile) {
        _mobile = [[AwesomeTextField alloc] init];
        _mobile.underlineHighLightColor = BlueColor;
        _mobile.underlineWidth = 1;
        _mobile.placeholderColor = GrayColor;
        _mobile.placeholder = @"手机";
        _mobile.textColor = LightBlackColor;
        _mobile.font = [UIFont systemFontOfSize:16];
        _mobile.text = @"步步高";
        _mobile.delegate = self;
        _mobile.maxCharacterNumber = 20;
        _mobile.showCharacterNumber = YES;
    }
    return _mobile;
}

- (AwesomeTextField *)street
{
    if (!_street) {
        _street = [[AwesomeTextField alloc] init];
        _street.underlineHighLightColor = BlueColor;
        _street.underlineWidth = 1;
        _street.placeholderColor = GrayColor;
        _street.placeholder = @"街道";
        _street.textColor = LightBlackColor;
        _street.font = [UIFont systemFontOfSize:16];
        _street.delegate = self;
        _street.text = @"武珞路";
        _street.maxCharacterNumber = 50;
        _street.showCharacterNumber = YES;
    }
    return _street;
}

- (AwesomeTextField *)city
{
    if (!_city) {
        _city = [[AwesomeTextField alloc] init];
        _city.underlineHighLightColor = BlueColor;
        _city.underlineWidth = 1;
        _city.placeholderColor = GrayColor;
        _city.placeholder = @"城市";
        _city.textColor = LightBlackColor;
        _city.font = [UIFont systemFontOfSize:16];
        _city.delegate = self;
        _city.text = @"武昌卓刀泉";
        _city.maxCharacterNumber = 6;
        _city.showCharacterNumber = YES;
    }
    return _city;
}

- (MDButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [[MDButton alloc] init];
        _saveBtn.mdButtonType = Raised;
        _saveBtn.rippleColor = LightBlueColor;
        _saveBtn.backgroundColor = BlueColor;
        [_saveBtn addTarget:self action:@selector(saveMemberDeliveryAddress) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    return _saveBtn;
}


- (void)saveMemberDeliveryAddress {
    if (![self isDataValid]) {
        return;
    }
    AddStreetRequest *request = [AddStreetRequest new];
    request.contact = _contact.textField.text;
    request.mobile = _mobile.textField.text;
    request.city = _city.textField.text;
    request.street = _street.textField.text;
    
    __block NSString *successMessage = nil;
    [[RequestManager sharedRequestManager]sendRequest:request successed:^(BaseResponseModel *response) {
        AddStreetResponse * streetResponse = (AddStreetResponse *)response;
        successMessage = streetResponse.successMessage;
    } failed:^(int errorCode, NSString *errorMsg) {
        NSLog(@"errorCode :%d , errorMsg :%@", errorCode,errorMsg);
    }];
    NSLog(@"----- %@",successMessage);
}

- (BOOL)isDataValid {
    if (!_contact.text.length) {
        [ViewHelper showPromptText:@"请输入收件人姓名"];
        return NO;
    }
   
    NSString *mobile = _mobile.text;
    if ([Utils isEmpty:mobile]) {
        [ViewHelper showPromptText:@"请输入手机号码或电话号码"];
        return NO;
    }
    
    if (![mobile isPhoneNumberOrTelNumber]) {
        [ViewHelper showPromptText:@"手机号码或电话号码格式错误,固定电话请按照区号-号码-分机号的格式填写"];
        return NO;
    }
    if (!_street.text.length) {
        [ViewHelper showPromptText:@"请输入地址信息"];
        return NO;
    }
    
    if (_street.text.length > 50) {
        [ViewHelper showPromptText:@"详细地址最多50个字符"];
        return NO;
    }
    
    if ([_street.text isIncludeSpecialCharact]) {
        [ViewHelper showPromptText:@"地址信息中不能有特殊字符"];
        return NO;
    }
    return YES;
}
@end
