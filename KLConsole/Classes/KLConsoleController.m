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
@property (strong, nonatomic) NSArray *fixSource;
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
    if (addresscgs == nil) {
        // 从系统单例中取出挂载数据
        addresscgs = objc_getAssociatedObject(NSNotificationCenter.defaultCenter, @selector(consoleAddressSetup:));
        // 归档
        [NSKeyedArchiver archiveRootObject:addresscgs toFile:KLConsoleAddressPath];
    }
    NSArray<KLConsoleConfig *> *cgs = [NSKeyedUnarchiver unarchiveObjectWithFile:KLConsolePath];
    if (cgs == nil) {
        // 从系统单例中取出挂载数据
        cgs = objc_getAssociatedObject(NSNotificationCenter.defaultCenter, @selector(consoleSetup:));
        // 归档
        [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsolePath];
    }
    
    self.fixSource = @[ @{@"title" : @"环境配置",
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
                              @"subtitle" : @"阿里啄幕鸟"
                            },
                            @{@"title" : @"刷新率监测",
                              @"subtitle" : @"FPS监测"}
                        ]}
    ];
    
    // 添加固定配置
    [self.dataSource addObjectsFromArray:self.fixSource];
    // 添加通用配置
    [self.dataSource addObjectsFromArray:cgs];
    
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
    cell.accessoryType = UITableViewCellAccessoryNone;
    NSDictionary *outdata = self.dataSource[indexPath.section];
    NSArray *infos = [outdata valueForKey:@"infos"];
    cell.consoleSwitch.hidden = YES;

    if (0 == indexPath.section) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        KLConsoleAddressConfig *config = infos[indexPath.row];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@（%@）", config.title, config.address[config.addressIndex].name];
        cell.infoLabel.text = config.subtitle;
    } else if (1 == indexPath.section) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = [infos[indexPath.row] valueForKey:@"title"];
        cell.infoLabel.text = [infos[indexPath.row] valueForKey:@"subtitle"];
    } else if (2 == indexPath.section) {
        cell.titleLabel.text = [infos[indexPath.row] valueForKey:@"title"];
        cell.infoLabel.text = [infos[indexPath.row] valueForKey:@"subtitle"];
        cell.consoleSwitch.hidden = NO;
        cell.switchChangeCallBack = ^(BOOL on) {
           if (indexPath.row == 0) {
               // YKW
               if (on) {
                   [YKWoodpeckerManager.sharedInstance show];
               } else {
                   [YKWoodpeckerManager.sharedInstance hide];
               }
           } else {
               // FPS
               if (on) {
                   
               } else {
                   
               }
           }
        };
    } else {
        KLConsoleSecondConfig *config = infos[indexPath.row];
        cell.titleLabel.text = config.title;
        cell.infoLabel.text = config.subtitle;
        cell.consoleSwitch.hidden = !config.switchEnable;
        cell.accessoryType = config.switchEnable ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
        __weak typeof(cell) weakcell = cell;
        cell.switchChangeCallBack = ^(BOOL on) {
            // 1、获取关联属性
            void (^callBack)(NSIndexPath *, BOOL) = objc_getAssociatedObject(self, @selector(consoleSetupAndSelectedCallBack:));
            if (callBack) {
                callBack([NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - self.fixSource.count], weakcell.consoleSwitch.on); // 减去固定section个数
            }
        };
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
        // 不处理点击
    } else {
        // 扩展行点击
        // 1、获取开关
        KLConsoleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.consoleSwitch.hidden) {
            void (^callBack)(NSIndexPath *, BOOL) = objc_getAssociatedObject(self, @selector(consoleSetupAndSelectedCallBack:));
            if (callBack) {
                callBack([NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - self.fixSource.count], cell.consoleSwitch.on); // 减去固定section个数
            }
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
