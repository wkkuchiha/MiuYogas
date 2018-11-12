//
//  AppDelegate.m
//  MiuYoga
//
//  Created by uchiha on 2018/2/2.
//  Copyright © 2018年 creditease. All rights reserved.
//

#import "AppDelegate.h"
#import "GeneralDataCache.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "CommunityViewController.h"
#import "StoreViewController.h"
#import "UserDetailViewController.h"
#import "CommonMacro.h"
#import "URLHelper.h"



#import "RegisterViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [URLHelper setMiuyogaUrl:@"http://10.36.41.2:8080/"];
    // 检查是否通过点击通知进入app，如果是的责DictionNary为空
    NSDictionary * remoteNotify = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    self.window.rootViewController = [self createNewFeature:remoteNotify];
    [self.window makeKeyAndVisible];
    return YES;
}

- (UINavigationController *)createNewFeature:(NSDictionary *)remoreNotify {
    NSInteger loginState = [[GeneralDataCache sharedGeneralDataCache].loginState integerValue];
    loginState = 1;
    UINavigationController * navigationCtrl ;
    if (loginState == 1) {
        navigationCtrl = [[UINavigationController alloc]initWithRootViewController: [AppDelegate createIndexViewControllerWithNeedLoadUserInfo:YES]];
    } else {
        navigationCtrl = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
    }
    return navigationCtrl;
}

+ (IndexViewController *)createIndexViewControllerWithNeedLoadUserInfo:(BOOL)need {
    IndexViewController *indexCtrl = [IndexViewController new];
    HomeViewController *home = [HomeViewController new];
    CommunityViewController *community = [CommunityViewController new];
    StoreViewController *store = [StoreViewController new];
    UserDetailViewController *userDetail = [UserDetailViewController new];
    indexCtrl.viewControllers = @[home,community,store,userDetail];
    
    UITabBar *tabbar = indexCtrl.tabBar;
    tabbar.backgroundColor = WhiteColor;
    tabbar.barStyle = UIBarStyleDefault;
    [tabbar setTintColor:RedColor];
    
    UITabBarItem *tabBarItem0 = [tabbar.items objectAtIndex:0];
    UITabBarItem *tabBarItem1 = [tabbar.items objectAtIndex:1];
    UITabBarItem *tabBarItem2 = [tabbar.items objectAtIndex:2];
    UITabBarItem *tabBarItem3 = [tabbar.items objectAtIndex:3];
    
    tabBarItem0.title = @"首页";
    tabBarItem1.title = @"社区";
    tabBarItem2.title = @"商城";
    tabBarItem3.title = @"我的";
    
    [tabBarItem0 setImage:[UIImage imageNamed:@"home_icon"]];
    [tabBarItem1 setImage:[UIImage imageNamed:@"community_icon"]];
    [tabBarItem2 setImage:[UIImage imageNamed:@"store_icon"]];
    [tabBarItem3 setImage:[UIImage imageNamed:@"user_icon"]];
    
    [tabBarItem0 setSelectedImage:[UIImage imageNamed:@"home_icon_select"]];
    [tabBarItem1 setSelectedImage:[UIImage imageNamed:@"community_icon_select"]];
    [tabBarItem2 setSelectedImage:[UIImage imageNamed:@"store_icon_select"]];
    [tabBarItem3 setSelectedImage:[UIImage imageNamed:@"user_icon_select"]];
    
    return indexCtrl;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive st ate. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
