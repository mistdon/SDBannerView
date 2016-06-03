//
//  SDBannerView.h
//  SDBannerView
//
//  Created by shendong on 16/3/17.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PageControlType){
    PageControlTypeUpleft = 1,
    PageControlTypeUpCenter,
    PageControlTypeUpRight,
    PageControlTypeDownLeft,
    PageControlTypeDownCenter,
    PageControlTypeDownRight
};
@interface SDBannerView : UIView
/**
 *  占位图片
 */
@property (nonatomic, strong) UIImage *placeholderImage;
/**
 *  轮播时差
 */
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;
/**
 *  PageControl的位置
 */
@property (nonatomic, assign) PageControlType pageType;
/**
 *  PageContril默认指示颜色
 */
@property (nonatomic, assign) UIColor *pageIndicatorTintColor;
/**
 *  pageControl
 */
@property (nonatomic, assign) UIColor *currentPageIndicatorTintColor;
/**
 *  当前被点击的图片索引
 */
@property (nonatomic, copy) void(^currentIndexDidTap)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray<UIImage *> *)names;

@end

