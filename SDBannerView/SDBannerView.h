//
//  SDBannerView.h
//  SDBannerView
//
//  Created by shendong on 16/3/17.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PageControlPosition){
    PageControlPositionUpleft = 1,
    PageControlPositionUpCenter,
    PageControlPositionUpRight,
    PageControlPositionDownLeft,
    PageControlPositionDownCenter,
    PageControlPositionDownRight
};
typedef NS_ENUM(NSInteger, SDScrollStyleAnimation) {
    SDScrollStyleAnimationNone,
    SDScrollStyleAnimationScale,
    SDScrollStyleAnimationPagCurl
};

@interface SDBannerView : UIView

@property (nonatomic, strong) NSArray *datasource;
/**
 *  占位图片
 */
@property (nonatomic, strong) UIImage *placeholderImage;

/**
 *  是否自动轮播, 默认=YES
 */
@property (nonatomic, assign) BOOL autoBanner;

/**
 *  轮播时差
 */
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;

/**
 *  PageControl的位置
 */
@property (nonatomic, assign) PageControlPosition pageType;


@property (nonatomic, assign) SDScrollStyleAnimation ScrollStyleAnimation;

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

/**
 *  Delete image data cache(删除图片数据缓存)
 */
- (void)clearImageDataCache;

@end

NS_ASSUME_NONNULL_END
