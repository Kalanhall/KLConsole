//
//  KLAppDelegate.m
//  KLConsole
//
//  Created by Kalanhall@163.com on 01/06/2020.
//  Copyright (c) 2020 Kalanhall@163.com. All rights reserved.
//

#import "KLAppDelegate.h"
@import KLConsole;

@implementation KLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [KLConsole consoleAddressSetup:^(NSMutableArray<KLConsoleSecondConfig *> *configs) {
        KLConsoleSecondConfig *A = KLConsoleSecondConfig.alloc.init;
        A.version = @"1.0";
        A.title = @"商城服务域名";
        A.subtitle = @"https://www.example.com/prod";
        A.selectedIndex = 0;
        
        KLConsoleThreeConfig *Aa = KLConsoleThreeConfig.alloc.init;
        Aa.title = @"生产环境";
        Aa.text = @"https://www.example.com/prod";
        KLConsoleThreeConfig *Ab = KLConsoleThreeConfig.alloc.init;
        Ab.title = @"开发环境";
        Ab.text = @"https://www.example.com/dev";
        KLConsoleThreeConfig *Ac = KLConsoleThreeConfig.alloc.init;
        Ac.title = @"测试环境";
        Ac.text = @"https://www.example.com/test";
        KLConsoleThreeConfig *Ad = KLConsoleThreeConfig.alloc.init;
        Ad.title = @"预发布环境";
        Ad.text = @"https://www.example.com/stadge";
        A.details = @[Aa, Ab, Ac, Ad];
        [configs addObject:A];
        
        KLConsoleSecondConfig *B = KLConsoleSecondConfig.alloc.init;
        B.version = @"1.0";
        B.title = @"商城H5服务域名";
        B.subtitle = @"https://www.example.com/prod1";
        B.selectedIndex = 0;
        
        KLConsoleThreeConfig *Ba = KLConsoleThreeConfig.alloc.init;
        Ba.title = @"生产环境";
        Ba.text = @"https://www.example.com/prod1";
        KLConsoleThreeConfig *Bb = KLConsoleThreeConfig.alloc.init;
        Bb.title = @"开发环境";
        Bb.text = @"https://www.example.com/dev1";
        KLConsoleThreeConfig *Bc = KLConsoleThreeConfig.alloc.init;
        Bc.title = @"测试环境";
        Bc.text = @"https://www.example.com/test1";
        KLConsoleThreeConfig *Bd = KLConsoleThreeConfig.alloc.init;
        Bd.title = @"预发布环境";
        Bd.text = @"https://www.example.com/stadge1";
        B.details = @[Ba, Bb, Bc, Bd];
        [configs addObject:B];
    }];
    
    [KLConsole consoleSetup:^(NSMutableArray<KLConsoleConfig *> * _Nonnull configs) {
        KLConsoleConfig *A = KLConsoleConfig.alloc.init;
        A.title = @"功能测试";
        
        KLConsoleSecondConfig *Aa = KLConsoleSecondConfig.alloc.init;
        Aa.title = @"H5访问测试";
        Aa.subtitle = @"点击输入链接访问";
        
        KLConsoleSecondConfig *Ab = KLConsoleSecondConfig.alloc.init;
        Ab.title = @"引导页测试";
        Ab.subtitle = @"点击查看";
        A.infos = @[Aa, Ab];
        [configs addObject:A];
        
        KLConsoleConfig *B = KLConsoleConfig.alloc.init;
        B.title = @"功能测试1";
        
        KLConsoleSecondConfig *Ba = KLConsoleSecondConfig.alloc.init;
        Ba.title = @"H5访问测试1";
        Ba.subtitle = @"点击输入链接访问1";
        
        KLConsoleSecondConfig *Bb = KLConsoleSecondConfig.alloc.init;
        Bb.title = @"引导页测试1";
        Bb.subtitle = @"点击查看1";
        Bb.switchEnable = YES;
        B.infos = @[Ba, Bb];
        [configs addObject:B];
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
