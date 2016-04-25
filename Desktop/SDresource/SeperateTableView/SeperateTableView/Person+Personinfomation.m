//
//  Person+Personinfomation.m
//  SeperateTableView
//
//  Created by shendong on 16/4/25.
//  Copyright © 2016年 shendong.enterprise. All rights reserved.
//

#import "Person+Personinfomation.h"

@implementation Person (Personinfomation)

- (NSDictionary *)personInfomation{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return @{@"name":self.name,
             @"age":[NSString stringWithFormat:@"%lu",self.age],
             @"birthday":self.birthday ? [formatter stringFromDate:self.birthday] : @""};
}

@end
