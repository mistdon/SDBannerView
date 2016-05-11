//
//  OpenURLOnlineNavigationViewController.m
//  OfficialDemo3D
//
//  Created by 刘博 on 14-2-20.
//  Copyright (c) 2014年 songjian. All rights reserved.
//

#import "OpenURLOnlineNavigationViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "MANaviAnnotationView.h"

/* 高德地图注册scheme:iosamap */
#define AMAPScheme @"iosamap://"

/* 高德地图URL调用方法及参数参照 http://lbs.amap.com/api/uri-api/web-uri-explain/ */

@interface OpenURLOnlineNavigationViewController()

@property (nonatomic, strong) MAPointAnnotation * destination;

@end

@implementation OpenURLOnlineNavigationViewController

#pragma mark - mapView delegate

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[MAPointAnnotation class]])
    {
        MANaviConfig * config = [[MANaviConfig alloc] init];
        config.destination = view.annotation.coordinate;
        config.appScheme = [self getApplicationScheme];
        config.appName = [self getApplicationName];
        config.strategy = MADrivingStrategyShortest;
        
        if(![MAMapURLSearch openAMapNavigation:config])
        {
            [MAMapURLSearch getLatestAMapApp];
        }
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MANaviAnnotationView *annotationView = (MANaviAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MANaviAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - Initialization

- (void)initDestination
{
    self.destination = [[MAPointAnnotation alloc] init];
    
    self.destination.coordinate = CLLocationCoordinate2DMake(39.923034, 116.388988);
    self.destination.title = @"在线导航";
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDestination];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.mapView.showsUserLocation = YES;
    
    [self.mapView addAnnotation:self.destination];
    [self.mapView selectAnnotation:self.destination animated:YES];
}

@end

