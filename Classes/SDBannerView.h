//
//  SDBannerView.h
//  SDBannerView
//
//  Created by shendong on 16/3/17.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PageControlType){
    PageControlTypeUpleft = 1,
    PageControlTypeUpCenter,
    PageControlTypeUpRight,
    PageControlTypeDownLeft,
    PageControlTypeDownCenter,
    PageControlTypeDownRight
};
NS_ASSUME_NONNULL_BEGIN

@interface SDBannerView : UIView

//! source images.
@property (nonatomic, strong) NSArray<__kindof NSString *> *images;

//! the placeholder Image, you should set it.
@property (nonatomic, strong, nullable) UIImage *placeholderImage;

//! current banner is showing
@property (nonatomic, assign, readonly) NSUInteger currentIndex;

//! whether or not auto scroll to next (if current position is the last, then turn to the first), default is YES.
@property (nonatomic, assign, getter=isAutoScroll) BOOL autoScroll;

//! auto scroll time interval, default value is 3.0.
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;

//! whether or not show the page control, default is YES.
@property (nonatomic, assign) BOOL showPage;

//! the position of the page control.
@property (nonatomic, assign) PageControlType pageType;

//! The tint color to be used for the page indicator.
@property (nonatomic, assign, nullable) UIColor *pageIndicatorTintColor;

//! The tint color to be used for the current page indicator.
@property (nonatomic, assign, nullable) UIColor *currentPageIndicatorTintColor;

//! the callback when you touch one of the images.
@property (nonatomic, copy) void(^currentIndexDidTap)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
