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
    
    [KLConsole consoleAddressSetup:^(NSMutableArray<KLConsoleAddressConfig *> *configs) {
        KLConsoleAddressConfig *aconfig = KLConsoleAddressConfig.alloc.init;
        aconfig.version = @"1.0";
        aconfig.title = @"商城服务域名";
        aconfig.subtitle = @"https://www.example.com/prod";
        aconfig.addressIndex = 0;
        
        KLConsoleAddress *a = KLConsoleAddress.alloc.init;
        a.name = @"生产环境";
        a.address = @"https://www.example.com/prod";
        KLConsoleAddress *b = KLConsoleAddress.alloc.init;
        b.name = @"开发环境";
        b.address = @"https://www.example.com/dev";
        KLConsoleAddress *c = KLConsoleAddress.alloc.init;
        c.name = @"测试环境";
        c.address = @"https://www.example.com/test";
        KLConsoleAddress *d = KLConsoleAddress.alloc.init;
        d.name = @"预发布环境";
        d.address = @"https://www.example.com/stadge";
        aconfig.address = @[a, b, c, d];
        [configs addObject:aconfig];
        
        KLConsoleAddressConfig *bconfig = KLConsoleAddressConfig.alloc.init;
        bconfig.version = @"1.0";
        bconfig.title = @"商城H5服务域名";
        bconfig.subtitle = @"https://www.example.com/prod1";
        bconfig.addressIndex = 0;
        
        KLConsoleAddress *e = KLConsoleAddress.alloc.init;
        e.name = @"生产环境";
        e.address = @"https://www.example.com/prod1";
        KLConsoleAddress *f = KLConsoleAddress.alloc.init;
        f.name = @"开发环境";
        f.address = @"https://www.example.com/dev1";
        KLConsoleAddress *g = KLConsoleAddress.alloc.init;
        g.name = @"测试环境";
        g.address = @"https://www.example.com/test1";
        KLConsoleAddress *h = KLConsoleAddress.alloc.init;
        h.name = @"预发布环境";
        h.address = @"https://www.example.com/stadge1";
        bconfig.address = @[e, f, g, h];
        [configs addObject:bconfig];
    }];
    
    [KLConsole consoleSetup:^(NSMutableArray<KLConsoleConfig *> * _Nonnull configs) {
        KLConsoleConfig *aconfig = KLConsoleConfig.alloc.init;
        aconfig.title = @"功能测试";
        
        KLConsoleSecondConfig *a = KLConsoleSecondConfig.alloc.init;
        a.title = @"H5访问测试";
        a.subtitle = @"点击输入链接访问";
        
        KLConsoleSecondConfig *b = KLConsoleSecondConfig.alloc.init;
        b.title = @"引导页测试";
        b.subtitle = @"点击查看";
        aconfig.infos = @[a, b];
        [configs addObject:aconfig];
        
        KLConsoleConfig *bconfig = KLConsoleConfig.alloc.init;
        bconfig.title = @"功能测试1";
        
        KLConsoleSecondConfig *c = KLConsoleSecondConfig.alloc.init;
        c.title = @"H5访问测试1";
        c.subtitle = @"点击输入链接访问1";
        
        KLConsoleSecondConfig *d = KLConsoleSecondConfig.alloc.init;
        d.title = @"引导页测试1";
        d.subtitle = @"点击查看1";
        d.switchEnable = YES;
        bconfig.infos = @[c, d];
        [configs addObject:bconfig];
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
