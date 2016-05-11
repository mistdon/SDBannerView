//
//  AppDelegate.m
//  JSPatchDemo
//
//  Created by shendong on 16/4/26.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "AppDelegate.h"
#import <JSPatch/JSPatch.h>
//JSPatch KEY
static NSString *const KJSPatchKEY = @"1285cb383ce9ea76"; //APP版本1.0

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    //JSPtach 官网            http://jspatch.com/Docs/intro
    //OC转js在线代码转换工具    http://bang590.github.io/JSPatchConvertor/
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"JSPatch"]) {
        [self configueJSPatch];
    }
    
    return YES;
}

/**
 *  配置JSPatch热修复
 */
- (void)configueJSPatch{
//    [JSPatch startWithAppKey:KJSPatchKEY];
    [JSPatch testScriptInBundle];  //本地测试
    [JSPatch sync];
    [JSPatch setupLogger:^(NSString * message) {
        NSLog(@"message");
    }];
    [JSPatch setupCallback:^(JPCallbackType type, NSDictionary *data, NSError *error) {
        NSLog(@"data = %@, error = %@",data,error);
    }];
}

@end
