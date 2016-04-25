//
//  Person+Personinfomation.h
//  SeperateTableView
//
//  Created by shendong on 16/4/25.
//  Copyright © 2016年 shendong.enterprise. All rights reserved.
//

#import "Person.h"

@interface Person (Personinfomation)

//适配器模式，实现将view和model的分离, 将model中的数据以基本类型NSDictionary传入到Cell的View中

/**
 *  获取格式化后,用于显示在cell中的信息
 *  key : @"name", @"age", @"birthday"
 *  @return
 */
- (NSDictionary *)personInfomation;

@end
