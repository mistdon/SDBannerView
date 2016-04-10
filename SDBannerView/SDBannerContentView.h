//
//  SDBannerContentView.h
//  SDBannerView
//
//  Created by Allen on 16/4/8.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDBannerContentView : UIView

@property (nonatomic, strong) UIImage *image;

- (void)imageOffsetValue:(float)value; //偏移的百分比

@end
