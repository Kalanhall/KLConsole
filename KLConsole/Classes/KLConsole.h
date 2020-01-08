//
//  KLConsole.h
//  KLConsole
//
//  Created by Logic on 2020/1/6.
//

#import <Foundation/Foundation.h>
#import "KLConsoleConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLConsole : NSObject

+ (void)consoleSetup:(void (^)(NSMutableArray<KLConsoleConfig *> *configs))setup;

@end

NS_ASSUME_NONNULL_END
