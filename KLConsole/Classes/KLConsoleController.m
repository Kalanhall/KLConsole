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
#import "KLConsole.h"
#import <objc/runtime.h>
@import YKWoodpecker;

@interface KLConsoleController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

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
    self.tableView.showsVerticalScrollIndicator = NO;
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
    NSArray<KLConsoleAddressConfig *> *addresscgs = [NSKeyedUnarchiver unarchiveObjectWithFile:KLConsoleAddressPath];
    NSArray<KLConsoleAddressConfig *> *cgs = [NSKeyedUnarchiver unarchiveObjectWithFile:KLConsolePath];
    self.dataSource = @[@{@"title" : @"环境配置",
                          @"infos" : addresscgs
                        },
                        
                        @{@"title" : @"设备信息",
                          @"infos" : @[
                            @{@"title" : @"基本信息",
                              @"subtitle" : @"系统及应用相关信息"}
                        ]},
                        
                        @{@"title" : @"调试工具",
                          @"infos" : @[
                            @{@"title" : @"YKWoodpecker",
                              @"subtitle" : @"阿里啄幕鸟"}
                        ]}
    ].mutableCopy;
    
    // 添加通用配置
    if (cgs.count) [self.dataSource addObjectsFromArray:cgs];
    
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
    NSDictionary *outdata = self.dataSource[indexPath.section];
    NSArray *infos = [outdata valueForKey:@"infos"];
    BOOL result = [[outdata valueForKey:@"title"] isEqual:@"调试工具"];
    cell.accessoryType = result ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    cell.consoleSwitch.hidden = !result;
    if (result) {
        cell.switchChangeCallBack = ^(BOOL on) {
            if (indexPath.row == 0) {
                if (on) {
                    [YKWoodpeckerManager.sharedInstance show];
                } else {
                    [YKWoodpeckerManager.sharedInstance hide];
                }
            }
        };
    }

    if (0 == indexPath.section) {
        KLConsoleAddressConfig *config = infos[indexPath.row];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@（%@）", config.title, config.address[config.addressIndex].name];
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
    header.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    NSDictionary *outdata = self.dataSource[section];
    [header setTitle:[outdata valueForKey:@"title"] forState:UIControlStateNormal];
    [header setTitleEdgeInsets:(UIEdgeInsets){0, 15, 0, 0}];
    [header setTitleColor:[UIColor colorWithRed:40/255.0 green:122/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [header setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return UIView.new;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLConsoleInfoController *vc = KLConsoleInfoController.alloc.init;
    NSDictionary *outdata = self.dataSource[indexPath.section];
    NSArray *infos = [outdata valueForKey:@"infos"];
    NSString *title = [infos[indexPath.row] valueForKey:@"title"];
    vc.title = title;
    
    if (indexPath.section == 0) {
        // 环境配置
        __weak typeof(self) weakself = self;
        NSArray<KLConsoleAddressConfig *> *infos = [outdata valueForKey:@"infos"];
        vc.config = infos[indexPath.row];
        vc.infoType = KLConsoleInfoTypeAddress;
        vc.selectedCallBack = ^() { [weakself reloadData]; };
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1) {
        // 系统信息
        vc.infoType = KLConsoleInfoTypeSystemInfo;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 2) {
        // 调试工具开关
        KLConsoleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.consoleSwitch setOn:!cell.consoleSwitch.on animated:YES];
        if (cell.consoleSwitch.on) {
            [YKWoodpeckerManager.sharedInstance show];
        } else {
            [YKWoodpeckerManager.sharedInstance hide];
        }
    } else {
        // 扩展行点击
        // 1、获取关联属性
        void (^callBack)(NSIndexPath *) = objc_getAssociatedObject(self, @selector(consoleSetupAndSelectedCallBack:));
        if (callBack) {
            callBack([NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 3]); // 减去固定section个数
        }
    }
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = NSMutableArray.array;
    }
    return _dataSource;
}

@end
