//
//  KLConsoleController.m
//  KLConsole
//
//  Created by Logic on 2020/1/6.
//

@import Masonry;
#import "KLConsoleController.h"
#import "KLConsoleCell.h"
#import "KLConsoleInfoController.h"
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sysctl.h>

@interface KLConsoleController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation KLConsoleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"控制台";
    self.view.backgroundColor = UIColor.whiteColor;
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancleCallBack)];

    self.tableView = [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerClass:KLConsoleCell.class forCellReuseIdentifier:KLConsoleCell.description];
    [self.tableView registerClass:KLConsoleInfoCell.class forCellReuseIdentifier:KLConsoleInfoCell.description];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    // 数据源
    self.dataSource = @[@{@"title" : @"信息", @"infos" : @[
                            @{@"title" : @"设备信息", @"subtitle" : @"查看设备相关信息"},
                            @{@"title" : @"崩溃日志", @"subtitle" : @"查看应用崩溃日志"}
                        ]},
                        @{@"title" : @"设置", @"infos" : @[
                            @{@"title" : @"环境配置", @"subtitle" : @"dev / test / prod 等环境配置"}
                        ]}
    ];
}

- (void)cancleCallBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *data = self.dataSource[section];
    return [[data valueForKey:@"infos"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    KLConsoleCell *cell = [tableView dequeueReusableCellWithIdentifier:KLConsoleCell.description];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *outdata = self.dataSource[indexPath.section];
    NSArray *infos = [outdata valueForKey:@"infos"];
    cell.titleLabel.text = [infos[indexPath.row] valueForKey:@"title"];
    cell.infoLabel.text = [infos[indexPath.row] valueForKey:@"subtitle"];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *header = UIButton.alloc.init;
    header.titleLabel.font = [UIFont systemFontOfSize:11];
    NSDictionary *outdata = self.dataSource[section];
    [header setTitle:[outdata valueForKey:@"title"] forState:UIControlStateNormal];
    [header setTitleEdgeInsets:(UIEdgeInsets){0, 15, 0, 0}];
    [header setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [header setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    [header setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        KLConsoleInfoController *vc = KLConsoleInfoController.alloc.init;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
