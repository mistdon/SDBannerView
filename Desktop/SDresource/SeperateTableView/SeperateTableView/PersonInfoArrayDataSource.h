//
//  PersonInfoArrayDataSource.h
//  SeperateTableView
//
//  Created by shendong on 16/4/25.
//  Copyright © 2016年 shendong.enterprise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^tableviewCellConfigrueBlock)(id cell, id item);

@interface PersonInfoArrayDataSource : NSObject<UITableViewDataSource>

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(tableviewCellConfigrueBlock)completeBlock;
- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
