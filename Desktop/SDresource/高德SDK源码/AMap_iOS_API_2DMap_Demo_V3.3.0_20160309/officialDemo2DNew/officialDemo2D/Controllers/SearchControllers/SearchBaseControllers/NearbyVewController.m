//
//  NearbyVewController.m
//  AMapSearchDemo
//
//  Created by xiaoming han on 15/9/7.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

#import "NearbyVewController.h"

#define kUserID @"d2"

@interface NearbyVewController ()<AMapNearbySearchManagerDelegate>
{
    AMapNearbySearchManager *_nearbyManager;
}

@end

@implementation NearbyVewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake(10, 100, 70, 25);
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"auto" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(10, 150,70,25);
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"upload" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(button2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame = CGRectMake(10, 200,70,25);
    button3.backgroundColor = [UIColor redColor];
    [button3 setTitle:@"clear" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(button3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.frame = CGRectMake(10, 250,70,25);
    button4.backgroundColor = [UIColor redColor];
    [button4 setTitle:@"search" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(button4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    //
    _nearbyManager = [AMapNearbySearchManager sharedInstance];
    _nearbyManager.delegate = self;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_nearbyManager stopAutoUploadNearbyInfo];
    _nearbyManager.delegate = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)button1
{
    if (_nearbyManager.isAutoUploading)
    {
        [_nearbyManager stopAutoUploadNearbyInfo];
    }
    else
    {
        [_nearbyManager startAutoUploadNearbyInfo];
    }
    
}

- (void)button2
{
    AMapNearbyUploadInfo *info = [[AMapNearbyUploadInfo alloc] init];
    info.userID = kUserID;
    info.coordinate = CLLocationCoordinate2DMake(39, 114);

    if ([_nearbyManager uploadNearbyInfo:info])
    {
        NSLog(@"YES");
    }
    else
    {
        NSLog(@"NO");
    }
}

- (void)button3
{
    [_nearbyManager clearUserInfoWithID:kUserID];
}

- (void)button4
{
    AMapNearbySearchRequest *request = [[AMapNearbySearchRequest alloc] init];
    request.center = [AMapGeoPoint locationWithLatitude:39.001 longitude:114.002];
    
    [self.search AMapNearbySearch:request];
    
}

#pragma mark -

- (AMapNearbyUploadInfo *)nearbyInfoForUploading:(AMapNearbySearchManager *)manager
{
    AMapNearbyUploadInfo *info = [[AMapNearbyUploadInfo alloc] init];
    info.userID = kUserID;
    info.coordinate = CLLocationCoordinate2DMake(39.004, 114.003);
    
    return info;
}

- (void)onUserInfoClearedWithError:(NSError *)error
{
    if (error)
    {
        NSLog(@"clear error: %@", error);
    }
    else
    {
        NSLog(@"clear OK");
    }
}

- (void)onNearbyInfoUploadedWithError:(NSError *)error
{
    if (error)
    {
        NSLog(@"upload error: %@", error);
    }
    else
    {
        NSLog(@"upload OK");
    }
}

#pragma mark -

- (void)onNearbySearchDone:(AMapNearbySearchRequest *)request response:(AMapNearbySearchResponse *)response
{
    NSLog(@"nearby request:%@", [request formattedDescription]);
    NSLog(@"nearby responst:%@", [response formattedDescription]);
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for (AMapNearbyUserInfo *info in response.infos)
    {
        MAPointAnnotation *anno = [[MAPointAnnotation alloc] init];
        anno.title = [NSString stringWithFormat:@"%@(距离 %.1f 米)", info.userID, info.distance];
        anno.subtitle = [[NSDate dateWithTimeIntervalSince1970:info.updatetime] descriptionWithLocale:[NSLocale currentLocale]];
        
        anno.coordinate = CLLocationCoordinate2DMake(info.location.latitude, info.location.longitude);
        
        [self.mapView addAnnotation:anno];
    }
    
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];

}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *poiIdentifier = @"nearbyIdentifier";
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        
        return poiAnnotationView;
    }
    
    return nil;
}


@end
