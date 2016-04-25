//
//  Person.m
//  SeperateTableView
//
//  Created by shendong on 16/4/25.
//  Copyright © 2016年 shendong.enterprise. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithName:(NSString *)name age:(NSUInteger)age birth:(NSDate*)birthday{
    return [[self alloc] initWithName:name age:age birth:birthday];
}

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age birth:(NSDate*)birthday{
    self      = [super init];
    if (self == nil)return nil;
    _name     = [name copy];
    _age      = age;
    _birthday = birthday;
    return self;
}
@end
