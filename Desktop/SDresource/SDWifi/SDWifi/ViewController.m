//  iOS WIFI开发相关
//  Github:  https://github.com/momo13014
//  请至Github主页查询实现过程
//
//
//  ViewController.m
//  SDWifi
//
//  Created by shendong on 16/4/26.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "ViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NEHotspotHelper.h>
#import "SViewController.h"


#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ViewController

#pragma mark - lazyloading -
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 100)];
        _textView.text = @"甚至，她连穿衣打扮都极度不自信，每天出门前总要对着大镜子照了又照，将室友问了个遍还是不放心，若是将要置身一场公众活动便更是忧心忡忡。";
    }
    return _textView;
}

#pragma mark - lifecycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    [self getCurrentWifiInfomaton];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:self.textView];
}
#pragma mark - IBAction -
- (IBAction)turnonToWifiSettingAction:(UIBarButtonItem *)sender {

//    NSArray *supports  =[NEHotspotHelper supportedNetworkInterfaces];
//    NSLog(@"supprots = %@", supports);
    SViewController *svvv = [[SViewController alloc] init];
    [self.navigationController pushViewController:svvv animated:YES];
}

#pragma mark - private method
/**
 *  获取当前连接wifi的信息
 */
- (void)getCurrentWifiInfomaton {
    NSDictionary *wifis  = [self fetchSSIDInfo];
    NSLog(@"wifis = %@",wifis);
    NSString *ssid = [[wifis objectForKey:@"SSID"] lowercaseString];
    NSLog(@"ssid = %@",ssid);
}
- (id)fetchSSIDInfo{
    NSArray *wifis = (id)CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *wifiname in wifis) {
        info = (id)CFBridgingRelease(CNCopyCurrentNetworkInfo((CFStringRef)wifiname));
        if (info && [info count]) {
            break;
        }
    }
    return info;
}
/**
 *  app内跳转至WIFI设置界面
 */
- (void)trunOnToWIFISetting {
     NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
     if ([[UIApplication sharedApplication] canOpenURL:url]) {
         [[UIApplication sharedApplication] openURL:url];
     }
}
- (void)testLibararyReference {
    NSString *keyword = @"Reference";
    if ([UIReferenceLibraryViewController dictionaryHasDefinitionForTerm:keyword]) {
        UIReferenceLibraryViewController *reference = [[UIReferenceLibraryViewController alloc] initWithTerm:keyword];
        [self presentViewController:reference animated:YES completion:NULL];
    }
}
@end
