//
//  AppDelegate.m
//  SPC330
//
//  Created by shendong on 16/5/5.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "AppDelegate.h"
#import "SDTabBarController.h"
#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import <MMDrawerController.h>
#import "LeftViewController.h"

#import "SDSViewController.h"
#import "SDLeftSideViewController.h"
#import "SDSideDrawerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    SDTabBarController *tabbarController = [[SDTabBarController alloc] init];
    NSArray *normalArray   = @[[UIImage imageNamed:@"tab_buddy_nor"],[UIImage imageNamed:@"tab_me_nor"]];
    NSArray *selectedArray = @[[UIImage imageNamed:@"tab_buddy_press"],[UIImage imageNamed:@"tab_me_press"]];
    NSArray *titles        = @[@"健康",@"我的"];
    
    ViewController *vc1       = [ViewController new];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    SecondViewController *vc2 = [SecondViewController new];
    ThirdViewController *vc3  = [ThirdViewController new];

    [tabbarController.tabBarView setItems:normalArray selected:selectedArray title:titles];
    [tabbarController.tabBarView setCenteralItem:[UIImage imageNamed:@"btn_release"] title:@"首页"];
    
    tabbarController.tabBarView.selectedTextColor = [UIColor greenColor];
    tabbarController.tabBarView.normalTextColor   = [UIColor grayColor];
    tabbarController.viewControllers              = @[nav1,vc2,vc3];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabbarController];
    self.window                    = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor    = [UIColor whiteColor];
    

    LeftViewController *left = [[LeftViewController alloc] init];

    
    MMDrawerController *drawer = [[MMDrawerController alloc] initWithCenterViewController:nav leftDrawerViewController:left];
    [drawer setMaximumLeftDrawerWidth:SD_SCREENWIDTH * 0.8 animated:YES completion:^(BOOL finished) {
        ;
    }];
    
    [drawer setRestorationIdentifier:@"sdMMDrawerController"];
     drawer.shouldStretchDrawer = NO;
    [drawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawer setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    self.window.rootViewController = drawer;
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
