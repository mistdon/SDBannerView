//
//  SDTabBarView.h
//  SPC330
//
//  Created by shendong on 16/5/6.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SD_SCREENWIDTH   [UIScreen mainScreen].bounds.size.width
#define SD_SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

@protocol SDTabBarViewDelegate <NSObject>

@required

- (void)sd_buttonItemClicked:(NSInteger )tag;

@end

@interface SDTabBarView : UIView

@property (nonatomic, assign) BOOL showCenteralItem; //default is NO

@property (nonatomic, strong) UIColor *normalTextColor;

@property (nonatomic, strong) UIColor *selectedTextColor;  //文字颜色

@property (nonatomic, assign) NSInteger selectedItemIndex;

@property (nonatomic, weak) id<SDTabBarViewDelegate>delegate;

- (void)setItems:(NSArray<__kindof UIImage *> *)normal selected:(NSArray<__kindof UIImage *> *)selected title:(NSArray<__kindof NSString *> *)titles;
- (void)setCenteralItem:(UIImage *)image title:(NSString *)title;

@end
