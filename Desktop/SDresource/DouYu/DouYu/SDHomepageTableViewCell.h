//
//  SDHomepageTableViewCell.h
//  DouYu
//
//  Created by shendong on 16/5/11.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const SDHomePageCellHeaderImage = @"homePageCellHeaderImage";
static NSString *const SDHomePageCellHeaderTitle = @"homePageCellHeaderTitle";
static CGFloat const SDHomePageCellEdgeSet       = 10;

@interface SDHomepageTableViewCell : UITableViewCell

- (void)configureSubViews:(NSDictionary *)dictionary;

@end
