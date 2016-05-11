//
//  SDSViewController.h
//  SPC330
//
//  Created by shendong on 16/5/9.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDTabBarController.h"

@interface SDSViewController : UIViewController

@property (nonatomic, strong) UIViewController *leftViewController;

@property (nonatomic, strong) UINavigationController *centralNavigationViewController;

@property (nonatomic, strong) SDTabBarController *centralTabBarViewController;

@property (nonatomic, assign) CGFloat leftViewScaleValue; //0.0~1.0, default is 0.8

- (instancetype)initWithCenteralViewController:(UINavigationController *)centralViewController left:(UIViewController *)leftViewController;

@end
