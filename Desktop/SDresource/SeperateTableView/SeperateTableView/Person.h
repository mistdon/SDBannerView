//
//  Person.h
//  SeperateTableView
//
//  Created by shendong on 16/4/25.
//  Copyright © 2016年 shendong.enterprise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nullable,nonatomic, copy  ) NSString   *name;
@property (nonatomic, assign) NSUInteger age;
@property (nullable,nonatomic, strong) NSDate     *birthday;

+ (nullable instancetype)personWithName:(nullable NSString *)name age: ( NSUInteger)age birth: (nullable NSDate*)birthday;

@end

NS_ASSUME_NONNULL_END