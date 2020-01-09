//
//  KLViewController.m
//  KLConsole
//
//  Created by Kalanhall@163.com on 01/06/2020.
//  Copyright (c) 2020 Kalanhall@163.com. All rights reserved.
//

#import "KLViewController.h"
@import KLConsole;

@interface KLViewController ()

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [KLConsole.addressConfigs enumerateObjectsUsingBlock:^(KLConsoleAddressConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"域名注释：%@， 域名链接：%@", obj.title, obj.subtitle);
    }];
    
    [KLConsole.configs enumerateObjectsUsingBlock:^(KLConsoleConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"分组名称 - %@：%@", @(idx), obj.title);
        [obj.infos enumerateObjectsUsingBlock:^(KLConsoleSecondConfig *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"功能名称：%@", obj.title);
        }];
    }];
    

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [KLConsole consoleSetupAndSelectedCallBack:^(NSIndexPath * _Nonnull indexPath, BOOL switchOn) {
        KLConsoleConfig *config = KLConsole.configs[indexPath.section];
        NSLog(@"分组名称：%@， 功能名称：%@ switch: %@", config.title, config.infos[indexPath.row].title, @(switchOn));
    }];
//    id test = NSString.new;
//    [test objectAtIndex:0];
}

@end
