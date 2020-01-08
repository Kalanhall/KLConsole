//
//  KLConsoleInfoController.m
//  KLConsole
//
//  Created by Logic on 2020/1/6.
//

#import "KLConsoleInfoController.h"
#import "KLConsoleCell.h"
@import Masonry;
@import KLCategory;

@interface KLConsoleInfoController ()

@end

@implementation KLConsoleInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备信息";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    [self.tableView registerClass:KLConsoleInfoCell.class forCellReuseIdentifier:KLConsoleInfoCell.description];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchSystemInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLConsoleInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:KLConsoleInfoCell.description];
    NSDictionary *info = self.fetchSystemInfos[indexPath.row];
    cell.titleLabel.text = [info valueForKey:@"title"];
    cell.infoLabel.text = [info valueForKey:@"text"];
    return cell;
}

- (NSArray *)fetchSystemInfos
{
    NSArray *systemInfos = @[
            @{
                @"title" : @"应用名称",
                @"text" : [UIDevice kl_appDisplayName]
            },
            @{
                @"title" : @"版本号",
                @"text" : [UIDevice kl_appShortVersion]
            },
            @{
                @"title" : @"Build号",
                @"text" : [UIDevice kl_appBuildVersion]
            },
            @{
                @"title" : @"Bundle Id",
                @"text" : [UIDevice kl_appIdentifier]
            }
            , @{
                @"title" : @"手机系统",
                @"text" : [UIDevice kl_OSVersion]
            },
            @{
                @"title" : @"是否发布版本",
                @"text" : DEBUG ? @"是" : @"否"
            },
            @{
                @"title" : @"设备类型",
                @"text" : [UIDevice kl_currentModel]
            },
            @{
                @"title" : @"分辨率(宽高)",
                @"text" : [NSString stringWithFormat:@"%.1f x %.1f @scale %.1f", [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].scale]
            }, @{
                @"title" : @"运营商",
                @"text" : [UIDevice kl_carrierName]
            }, @{
                @"title" : @"渠道名称",
                @"text" : DEBUG ? @"开发包" : @"生产包"
            }, @{
                @"title" : @"系统语言",
                @"text" : [UIDevice kl_OSLanguage]
            }, @{
                @"title" : @"是否越狱",
                @"text" : [NSString stringWithFormat:@"%@", [UIDevice kl_isJailBroken] ? @"是" : @"否"]
            }, @{
                @"title" : @"ip地址(ipv4)",
                @"text" : [UIDevice kl_IPV4]
            }, @{
                @"title" : @"ip地址(ipv6)",
                @"text" : [UIDevice kl_IPV6]
            }, @{
                @"title" : @"系统位数",
    #ifdef __LP64__
                @"text" : @"64位"
    #else
                @"text" : @"32位"
    #endif
            }
        ];

    return systemInfos;
}



@end
