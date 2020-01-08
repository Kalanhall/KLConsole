//
//  KLConsoleConfig.h
//  KLCategory
//
//  Created by Kalan on 2020/1/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLConsoleAddress : NSObject <NSCoding>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *address;

@end

@interface KLConsoleConfig : NSObject <NSCoding>

@property (copy, nonatomic) NSString *version;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (copy, nonatomic) NSArray<KLConsoleAddress *> *address;
@property (assign, nonatomic) NSInteger addressIndex;

@end

NS_ASSUME_NONNULL_END
