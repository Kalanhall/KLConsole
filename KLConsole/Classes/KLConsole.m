//
//  KLConsole.m
//  KLConsole
//
//  Created by Logic on 2020/1/6.
//

#import "KLConsole.h"
#import "KLConsoleController.h"
#import <objc/runtime.h>

@implementation KLConsole

+ (void)consoleSetup:(void (^)(NSMutableArray<KLConsoleConfig *> *configs))setup
{
    NSArray<KLConsoleConfig *> *cachecgs = [NSKeyedUnarchiver unarchiveObjectWithFile:KLConsolePath];
    __block NSMutableArray<KLConsoleConfig *> *cgs = NSMutableArray.array;
    setup(cgs);
    if (cachecgs) {
        if (cachecgs.count != cgs.count) {
            [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsolePath];
        } else {
            [cachecgs enumerateObjectsUsingBlock:^(KLConsoleConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                // 一级列表检查
                if (![obj.title isEqualToString:cgs[idx].title]) {
                    [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsolePath];
                    *stop = YES;
                }
                // 二级列表检查
                else {
                    if (obj.infos.count != cgs[idx].infos.count) {
                        [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsolePath];
                        *stop = YES;
                    } else {
                        [obj.infos enumerateObjectsUsingBlock:^(KLConsoleSecondConfig * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop) {
                            if (![obj2.title isEqualToString:cgs[idx].infos[idx2].title]) {
                                [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsolePath];
                                *stop = YES;
                            }
                        }];
                    }
                }
            }];
        }
    } else {
        [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsolePath];
    }
}

+ (NSArray<KLConsoleConfig *> *)configs
{
    NSArray<KLConsoleConfig *> *cachecgs = [NSKeyedUnarchiver unarchiveObjectWithFile:KLConsolePath];
    return cachecgs;
}

+ (void)consoleAddressSetup:(void (^)(NSMutableArray<KLConsoleAddressConfig *> *configs))setup
{
    NSArray<KLConsoleAddressConfig *> *cachecgs = [NSKeyedUnarchiver unarchiveObjectWithFile:KLConsoleAddressPath];
    __block NSMutableArray<KLConsoleAddressConfig *> *cgs = NSMutableArray.array;
    setup(cgs);
    if (cachecgs) {
        if (cachecgs.count != cgs.count) {
            [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsoleAddressPath];
        } else {
            [cachecgs enumerateObjectsUsingBlock:^(KLConsoleAddressConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj.version isEqualToString:cgs[idx].version]) {
                    [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsoleAddressPath];
                    *stop = YES;
                }
            }];
        }
    } else {
        [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsoleAddressPath];
    }
}

+ (NSArray<KLConsoleAddressConfig *> *)addressConfigs
{
    NSArray<KLConsoleAddressConfig *> *cachecgs = [NSKeyedUnarchiver unarchiveObjectWithFile:KLConsoleAddressPath];
    return cachecgs;
}

+ (void)consoleSetupAndSelectedCallBack:(void (^)(NSIndexPath *indexPath))callBack
{
    KLConsoleController *vc = KLConsoleController.alloc.init;
    // 关联属性
    objc_setAssociatedObject(vc, @selector(consoleSetupAndSelectedCallBack:), callBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UINavigationController *nav = [UINavigationController.alloc initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
