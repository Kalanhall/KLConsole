//
//  KLConsoleController.m
//  KLConsole
//
//  Created by Logic on 2020/1/6.
//

#import "KLConsoleController.h"
#import "KLConsoleCell.h"
#import "KLConsoleInfoController.h"
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sysctl.h>
#import "KLConsoleConfig.h"

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

    self.tableView = [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.sectionFooterHeight = 15;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    [self.tableView registerClass:KLConsoleCell.class forCellReuseIdentifier:KLConsoleCell.description];
    [self.tableView registerClass:KLConsoleInfoCell.class forCellReuseIdentifier:KLConsoleInfoCell.description];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self reloadData];
}

- (void)reloadData
{
    // 数据源
    NSArray<KLConsoleConfig *> *cachecgs = [NSKeyedUnarchiver unarchiveObjectWithFile:KLConsoleAddressPath];
    self.dataSource = @[@{@"title" : @"环境设置",
                          @"infos" : cachecgs
                        },
                        
                        @{@"title" : @"设备&App信息",
                          @"infos" : @[
                            @{@"title" : @"设备信息",
                              @"subtitle" : @"App相关信息"}
                        ]},
                        
                        @{@"title" : @"日志&日志上报&功能测试",
                          @"infos" : @[
                            @{@"title" : @"崩溃日志",
                              @"subtitle" : @"Log相关信息"},
                            @{@"title" : @"功能测试",
                              @"subtitle" : @"应用崩溃日志"}
                        ]}
    ];
    [self.tableView reloadData];
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

    if (0 == indexPath.section) {
        KLConsoleConfig *config = infos[indexPath.row];
        cell.titleLabel.text = config.title;
        cell.infoLabel.text = config.address[config.addressIndex].address;
    } else {
        cell.titleLabel.text = [infos[indexPath.row] valueForKey:@"title"];
        cell.infoLabel.text = [infos[indexPath.row] valueForKey:@"subtitle"];
    }

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
    [header setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return UIView.new;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        KLConsoleInfoController *vc = KLConsoleInfoController.alloc.init;
        NSDictionary *outdata = self.dataSource[indexPath.section];
        NSArray<KLConsoleConfig *> *infos = [outdata valueForKey:@"infos"];
        vc.title = infos[indexPath.row].title;
        vc.config = infos[indexPath.row];
        vc.infoType = KLConsoleInfoTypeAddress;
        [self.navigationController pushViewController:vc animated:YES];
        
        __weak typeof(self) weakself = self;
        vc.selectedCallBack = ^(KLConsoleAddress * _Nonnull address) {
            [weakself reloadData];
        };
    } else if (indexPath.section == 1) {
        KLConsoleInfoController *vc = KLConsoleInfoController.alloc.init;
        vc.title = @"设备信息";
        vc.infoType = KLConsoleInfoTypeSystemInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
