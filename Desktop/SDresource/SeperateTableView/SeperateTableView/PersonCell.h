//
//  PersonCell.h
//  SeperateTableView
//
//  Created by shendong on 16/4/25.
//  Copyright © 2016年 shendong.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonCell : UITableViewCell

+ (nonnull UINib *)nib;

- (void)configureForPerson:(nonnull NSDictionary *)personinfo;

@end

NS_ASSUME_NONNULL_END