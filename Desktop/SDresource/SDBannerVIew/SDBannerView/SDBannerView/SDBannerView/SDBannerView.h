//
//  SDBannerView.h
//  SDBannerView
//
//  Created by shendong on 16/3/17.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PageControlPosition){
    PageControlPositionUpleft = 1,
    PageControlPositionUpCenter,
    PageControlPositionUpRight,
    PageControlPositionDownLeft,
    PageControlPositionDownCenter,
    PageControlPositionDownRight
};
@interface SDBannerView : UIView

/**
 *  通过本地图片资源加载轮播图
 *
 *  @param frame <#frame description#>
 *  @param names <#names description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray<UIImage *> *)names;

/**
 *  获取网络图片并进行显示
 *
 *  @param frame     轮播图范围
 *  @param imageUrls 网络图片链接数组
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame urls:(NSArray<NSString *> *)imageUrls;


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


@end

