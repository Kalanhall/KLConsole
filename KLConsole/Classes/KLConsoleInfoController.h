//
//  KLConsoleInfoController.h
//  KLConsole
//
//  Created by Logic on 2020/1/6.
//

typedef NS_ENUM(NSUInteger, KLConsoleInfoType) {
    KLConsoleInfoTypeAddress,
    KLConsoleInfoTypeSystemInfo
};

#import <UIKit/UIKit.h>
#import "KLConsoleConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLConsoleInfoController : UITableViewController

/// 页面类型
@property (assign, nonatomic) KLConsoleInfoType infoType;
/// 当前域名配置
@property (strong, nonatomic) KLConsoleConfig *config;

@property (copy, nonatomic) void (^selectedCallBack)();

@end

NS_ASSUME_NONNULL_END
