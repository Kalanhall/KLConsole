//
//  KLConsoleAddressConfig.h
//  KLCategory
//
//  Created by Kalan on 2020/1/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 三级级扩展数据模型
@interface KLConsoleAddress : NSObject <NSCoding>

/// 域名中文注释
@property (copy, nonatomic) NSString *name;
/// 域名地址
@property (copy, nonatomic) NSString *address;

@end

// 二级扩展数据模型
@interface KLConsoleAddressConfig : NSObject <NSCoding>

/// 环境版本
@property (copy, nonatomic) NSString *version;
/// 域名中文注释
@property (copy, nonatomic) NSString *title;
/// 环境当前选中
@property (copy, nonatomic) NSString *subtitle;
/// 环境集合
@property (copy, nonatomic) NSArray<KLConsoleAddress *> *address;
/// 环境当前选中下标
@property (assign, nonatomic) NSInteger addressIndex;

@end

// 二级扩展数据模型
@interface KLConsoleSecondConfig : NSObject <NSCoding>

/// row标题
@property (copy, nonatomic) NSString *title;
/// row副标题
@property (copy, nonatomic) NSString *subtitle;
/// 显示开关
@property (assign, nonatomic) BOOL switchEnable;

@end

// 一级扩展数据模型
@interface KLConsoleConfig : NSObject <NSCoding>

/// section标题
@property (copy, nonatomic) NSString *title;
/// row数组
@property (copy, nonatomic) NSArray<KLConsoleSecondConfig *> *infos;

@end

NS_ASSUME_NONNULL_END
