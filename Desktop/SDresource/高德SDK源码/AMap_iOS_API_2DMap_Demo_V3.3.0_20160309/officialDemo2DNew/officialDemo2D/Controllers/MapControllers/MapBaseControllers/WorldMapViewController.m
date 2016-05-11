//
//  WorldMapViewController.m
//  officialDemo2D
//
//  Created by xiaoming han on 15/12/29.
//  Copyright © 2015年 AutoNavi. All rights reserved.
//

#import "WorldMapViewController.h"

#define kParisLocationLatitude  48.845529
#define kParisLocationLongitude 2.351030
#define kParisLocationZoomLevel 10.1

#define SwitchItemTitle(isAbroad) ((isAbroad) ? (@"北京") : (@"巴黎"))

@implementation WorldMapViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)initNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:SwitchItemTitle(self.mapView.isAbroad)
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(switchAction)];
}


#pragma mark - Actions

- (void)switchAction
{
    BOOL isAbroad = self.mapView.isAbroad;
    if (isAbroad)
    {
        self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
    }
    else
    {
        // 显示北京
        [self.mapView setZoomLevel:kParisLocationZoomLevel];
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(kParisLocationLatitude, kParisLocationLongitude)];
    }
    
    self.navigationItem.rightBarButtonItem.title = SwitchItemTitle(!isAbroad);
}


@end
