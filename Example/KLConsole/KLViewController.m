//
//  KLViewController.m
//  KLConsole
//
//  Created by Kalanhall@163.com on 01/06/2020.
//  Copyright (c) 2020 Kalanhall@163.com. All rights reserved.
//

#import "KLViewController.h"
@import KLConsole;
@import YKWoodpecker;

@interface KLViewController ()

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [YKWoodpeckerManager.sharedInstance show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [KLConsole consoleSetup:^(NSMutableArray<KLConsoleConfig *> *configs) {
        KLConsoleConfig *aconfig = KLConsoleConfig.alloc.init;
        aconfig.version = @"2.0";
        aconfig.title = @"商城地址";
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
        
        KLConsoleConfig *bconfig = KLConsoleConfig.alloc.init;
        bconfig.version = @"2.0";
        bconfig.title = @"商城地址1";
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
}

@end
