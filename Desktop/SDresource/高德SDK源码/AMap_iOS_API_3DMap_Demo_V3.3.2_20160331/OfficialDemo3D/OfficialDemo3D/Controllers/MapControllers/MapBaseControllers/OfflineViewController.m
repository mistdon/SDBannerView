//
//  OfflineViewController.m
//  Category_demo
//
//  Created by songjian on 13-7-9.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "OfflineViewController.h"
#import "OfflineDetailViewController.h"

@implementation OfflineViewController

#pragma mark - Action Handle

- (void)detailAction
{
    OfflineDetailViewController *detailViewController = [[OfflineDetailViewController alloc] init];
    detailViewController.mapView = self.mapView;
    detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark - Initialization

- (void)initNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"城市列表"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(detailAction)];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNavigationBar];
}

@end
