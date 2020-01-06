//
//  KLConsoleInfoController.m
//  KLConsole
//
//  Created by Logic on 2020/1/6.
//

#import "KLConsoleInfoController.h"
#import "KLConsoleCell.h"
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sysctl.h>
@import Masonry;

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
    cell.titleLabel.text = info.allKeys.firstObject;
    cell.infoLabel.text = info.allValues.firstObject;
    return cell;
}

- (NSArray *)fetchSystemInfos
{
    NSMutableString *sysInfo = [NSMutableString string];
    [sysInfo appendFormat:@"%@: %@\n", @"Name", [UIDevice currentDevice].name];

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *model = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    [sysInfo appendFormat:@"%@: %@\n", @"Model", [self currentModel:model]];
    [sysInfo appendFormat:@"%@: %@\n", @"Model No.", model];

    [sysInfo appendFormat:@"%@: %@ %@\n", @"System", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
    [sysInfo appendFormat:@"IP: %@\n", [self getIPAddress]];
    [sysInfo appendFormat:@"%@: %.1f x %.1f @scale %.1f\n", @"Screen", [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].scale];
    [sysInfo appendFormat:@"IDFV: %@\n", [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    [sysInfo appendFormat:@"App Name: %@\n", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]];
    [sysInfo appendFormat:@"Build ID: %@\n", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    [sysInfo appendFormat:@"App Version: %@\n", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [sysInfo appendFormat:@"Build Version: %@\n", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    [sysInfo appendFormat:@"Locale: %@\n", [[NSLocale currentLocale] localeIdentifier]];
    // User-Agent
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    [sysInfo appendFormat:@"User-Agent: %@\n", userAgent];
    // 结构化
    NSArray *infos = [sysInfo componentsSeparatedByString:@"\n"];
    NSMutableArray *sysInfos = [NSMutableArray arrayWithCapacity:infos.count];
    [infos enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *temp = [obj componentsSeparatedByString:@": "];
        if (temp.count == 2) {
            NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:1];
            [info setObject:temp.lastObject forKey:temp.firstObject];
            [sysInfos addObject:info];
        }
    }];
    return sysInfos;
}

// Credit to https://www.jianshu.com/p/82becd09b6f5
- (NSString *)getIPAddress {
    struct ifaddrs *ifAddrs = NULL;
    getifaddrs(&ifAddrs);
    while(ifAddrs) {
        if(AF_INET == ifAddrs->ifa_addr->sa_family) {
            if([[NSString stringWithCString:ifAddrs->ifa_name encoding:NSUTF8StringEncoding] isEqualToString:@"en0"]) {
                NSString *ip = [NSString stringWithCString:inet_ntoa(((struct sockaddr_in *)ifAddrs->ifa_addr)->sin_addr) encoding:NSUTF8StringEncoding];
                return ip;
            }
        }
        ifAddrs = ifAddrs->ifa_next;
    }
    return @"";
}

// Credit to https://www.jianshu.com/p/f2d83ddb09fe
- (NSString *)currentModel:(NSString *)model {
    if ([model isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([model isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([model isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([model isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([model isEqualToString:@"iPhone3,2"])    return @"iPhone 4 Verizon";
    if ([model isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([model isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([model isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([model isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([model isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([model isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([model isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([model isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([model isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([model isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([model isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([model isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([model isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([model isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([model isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([model isEqualToString:@"iPhone10,1"])   return @"iPhone 8 Global";
    if ([model isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus Global";
    if ([model isEqualToString:@"iPhone10,3"])   return @"iPhone X Global";
    if ([model isEqualToString:@"iPhone10,4"])   return @"iPhone 8 GSM";
    if ([model isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus GSM";
    if ([model isEqualToString:@"iPhone10,6"])   return @"iPhone X GSM";
    
    if ([model isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([model isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max (China)";
    if ([model isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([model isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    
    if ([model isEqualToString:@"i386"])         return @"Simulator 32";
    if ([model isEqualToString:@"x86_64"])       return @"Simulator 64";
    
    if ([model isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([model isEqualToString:@"iPad2,1"] ||
        [model isEqualToString:@"iPad2,2"] ||
        [model isEqualToString:@"iPad2,3"] ||
        [model isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([model isEqualToString:@"iPad3,1"] ||
        [model isEqualToString:@"iPad3,2"] ||
        [model isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([model isEqualToString:@"iPad3,4"] ||
        [model isEqualToString:@"iPad3,5"] ||
        [model isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([model isEqualToString:@"iPad4,1"] ||
        [model isEqualToString:@"iPad4,2"] ||
        [model isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([model isEqualToString:@"iPad5,3"] ||
        [model isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([model isEqualToString:@"iPad6,3"] ||
        [model isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7-inch";
    if ([model isEqualToString:@"iPad6,7"] ||
        [model isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9-inch";
    if ([model isEqualToString:@"iPad6,11"] ||
        [model isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([model isEqualToString:@"iPad7,1"] ||
        [model isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
    if ([model isEqualToString:@"iPad7,3"] ||
        [model isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    
    if ([model isEqualToString:@"iPad2,5"] ||
        [model isEqualToString:@"iPad2,6"] ||
        [model isEqualToString:@"iPad2,7"]) return @"iPad mini";
    if ([model isEqualToString:@"iPad4,4"] ||
        [model isEqualToString:@"iPad4,5"] ||
        [model isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([model isEqualToString:@"iPad4,7"] ||
        [model isEqualToString:@"iPad4,8"] ||
        [model isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([model isEqualToString:@"iPad5,1"] ||
        [model isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    
    if ([model isEqualToString:@"iPod1,1"]) return @"iTouch";
    if ([model isEqualToString:@"iPod2,1"]) return @"iTouch2";
    if ([model isEqualToString:@"iPod3,1"]) return @"iTouch3";
    if ([model isEqualToString:@"iPod4,1"]) return @"iTouch4";
    if ([model isEqualToString:@"iPod5,1"]) return @"iTouch5";
    if ([model isEqualToString:@"iPod7,1"]) return @"iTouch6";
    
    return @"高端设备，不错哟！";
}


@end
