//
//  ShareSearchBaseViewController.m
//  officialDemo2D
//
//  Created by xiaoming han on 15/10/29.
//  Copyright © 2015年 AutoNavi. All rights reserved.
//

#import "ShareSearchBaseViewController.h"

@interface ShareSearchBaseViewController ()
{
    UILabel *_tipLabel;
}
@end

@implementation ShareSearchBaseViewController

- (void)returnAction
{
    [super returnAction];
    
    self.mapView.showsUserLocation = NO;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNavigationBar];
    [self initTipView];
}

- (void)initNavigationBar
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                               target:self
                                                                               action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)initTipView
{
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50)];
    tipLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    tipLabel.textAlignment  = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.text = @"请点击导航栏右侧按钮生成短串并在浏览器打开";
    tipLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;

    [self.view addSubview:tipLabel];
    _tipLabel = tipLabel;
}

#pragma mark - Helper

- (void)openURLAtSafari:(NSString *)urlString
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void)shareAction
{
    NSLog(@"父类没有具体实现。");
}

#pragma mark - Delegate

- (void)onShareSearchDone:(AMapShareSearchBaseRequest *)request response:(AMapShareSearchResponse *)response
{
    NSLog(@"share response: shareURL = %@", response.shareURL);
    
    _tipLabel.text = [NSString stringWithFormat:@"分享短串：%@", response.shareURL];
    [self openURLAtSafari:response.shareURL];
}

@end
