//
//  KLConsole.m
//  KLConsole
//
//  Created by Logic on 2020/1/6.
//

#import "KLConsole.h"
#import "KLConsoleController.h"

@implementation KLConsole

+ (void)console
{
    KLConsoleController *vc = KLConsoleController.alloc.init;
    UINavigationController *nav = [UINavigationController.alloc initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

+ (void)consoleSetup:(void (^)(NSMutableArray<KLConsoleConfig *> *configs))setup
{
    NSArray<KLConsoleConfig *> *cachecgs = [NSKeyedUnarchiver unarchiveObjectWithFile:KLConsoleAddressPath];
    __block NSMutableArray<KLConsoleConfig *> *cgs = NSMutableArray.array;
    setup(cgs);
    if (cachecgs) {
        if (cachecgs.count != cgs.count) {
            [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsoleAddressPath];
        } else {
            [cachecgs enumerateObjectsUsingBlock:^(KLConsoleConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj.version isEqualToString:cgs[idx].version]) {
                    [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsoleAddressPath];
                    *stop = YES;
                }
            }];
        }
    } else {
        [NSKeyedArchiver archiveRootObject:cgs toFile:KLConsoleAddressPath];
    }
    
    [self console];
}

@end
