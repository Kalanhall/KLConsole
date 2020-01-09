//
//  KLConsoleAddressConfig.m
//  KLCategory
//
//  Created by Kalan on 2020/1/9.
//

#import "KLConsoleConfig.h"

@implementation KLConsoleAddress

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_address forKey:@"address"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _address = [aDecoder decodeObjectForKey:@"address"];
    }
    return self;
}

@end

@implementation KLConsoleAddressConfig

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_version forKey:@"version"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_subtitle forKey:@"subtitle"];
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeObject:@(_addressIndex) forKey:@"addressIndex"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _version = [aDecoder decodeObjectForKey:@"version"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _subtitle = [aDecoder decodeObjectForKey:@"subtitle"];
        _address = [aDecoder decodeObjectForKey:@"address"];
        _addressIndex = [[aDecoder decodeObjectForKey:@"addressIndex"] integerValue];
    }
    return self;
}

@end

@implementation KLConsoleSecondConfig

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_subtitle forKey:@"subtitle"];
    [aCoder encodeObject:@(_switchEnable) forKey:@"switchEnable"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _subtitle = [aDecoder decodeObjectForKey:@"subtitle"];
        _switchEnable = [[aDecoder decodeObjectForKey:@"switchEnable"] boolValue];
    }
    return self;
}

@end

@implementation KLConsoleConfig

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_infos forKey:@"infos"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _infos = [aDecoder decodeObjectForKey:@"infos"];
    }
    return self;
}

@end
