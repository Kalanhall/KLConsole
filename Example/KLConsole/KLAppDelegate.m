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
    [KLConsole consoleAddressSetup:^(NSMutableArray<KLConsoleRowConfig *> *configs) {
        KLConsoleRowConfig *A = KLConsoleRowConfig.alloc.init;
        A.version = NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"];
        A.title = @"商城服务域名";
        A.subtitle = @"https://www.example.com/prod";
        A.selectedIndex = 0;
        
        KLConsoleInfoConfig *Aa = KLConsoleInfoConfig.alloc.init;
        Aa.title = @"生产环境";
        Aa.text = @"https://www.example.com/prod";
        KLConsoleInfoConfig *Ab = KLConsoleInfoConfig.alloc.init;
        Ab.title = @"开发环境";
        Ab.text = @"https://www.example.com/dev";
        KLConsoleInfoConfig *Ac = KLConsoleInfoConfig.alloc.init;
        Ac.title = @"测试环境";
        Ac.text = @"https://www.example.com/test";
        KLConsoleInfoConfig *Ad = KLConsoleInfoConfig.alloc.init;
        Ad.title = @"预发布环境";
        Ad.text = @"https://www.example.com/stadge";
        A.details = @[Aa, Ab, Ac, Ad];
        [configs addObject:A];
    }];
    
    [KLConsole consoleSetup:^(NSMutableArray<KLConsoleSectionConfig *> * _Nonnull configs) {
        KLConsoleSectionConfig *A = KLConsoleSectionConfig.alloc.init;
        A.title = @"调试工具";
        
        KLConsoleRowConfig *Aa = KLConsoleRowConfig.alloc.init;
        Aa.title = @"YKWoodpecker";
        Aa.subtitle = @"啄幕鸟";
        Aa.switchEnable = YES;
        
        KLConsoleRowConfig *Ab = KLConsoleRowConfig.alloc.init;
        Ab.title = @"FLEX";
        Ab.subtitle = @"比较全面的越狱插件";
        Ab.switchEnable = YES;
        A.infos = @[Aa, Ab];
        [configs addObject:A];
        
        KLConsoleSectionConfig *B = KLConsoleSectionConfig.alloc.init;
        B.title = @"功能测试";
        
        KLConsoleRowConfig *Ba = KLConsoleRowConfig.alloc.init;
        Ba.title = @"H5访问测试";
        Ba.subtitle = @"点击输入链接访问";
        
        KLConsoleRowConfig *Bb = KLConsoleRowConfig.alloc.init;
        Bb.title = @"引导页测试";
        Bb.subtitle = @"点击查看";
        B.infos = @[Ba, Bb];
        [configs addObject:B];
    }];
    
    return YES;
}

@end
