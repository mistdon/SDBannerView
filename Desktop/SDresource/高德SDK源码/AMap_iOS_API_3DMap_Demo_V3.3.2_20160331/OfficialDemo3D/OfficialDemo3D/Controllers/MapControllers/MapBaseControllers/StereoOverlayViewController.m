//
//  StereoOverlayViewController.m
//  MAMapKit_Debug
//
//  Created by yi chen on 1/12/16.
//  Copyright © 2016 Autonavi. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "StereoOverlayViewController.h"
#import "CubeOverlayRenderer.h"
#import "CubeOverlay.h"

@interface StereoOverlayViewController ()

@property (nonatomic, strong) CubeOverlay * cubeOverlay;

@end

@implementation StereoOverlayViewController

- (CubeOverlay *)cubeOverlay
{
    if(_cubeOverlay == nil)
    {
        _cubeOverlay = [CubeOverlay cubeOverlayWithCenterCoordinate:CLLocationCoordinate2DMake(39.99325, 116.473209) lengthOfSide:5000.f];
    }
    
    return _cubeOverlay;
}

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[CubeOverlay class]])
    {
        CubeOverlayRenderer * renderer = [[CubeOverlayRenderer alloc] initWithCubeOverlay:overlay];
        
        return renderer;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didAddOverlayRenderers:(NSArray *)overlayRenderers
{
    MAMapStatus * mapStatus = [mapView getMapStatus];
    mapStatus.centerCoordinate = self.cubeOverlay.coordinate;
    mapStatus.cameraDegree = 60.f;
    mapStatus.rotationDegree = 135.f;
    
//    [mapView setMapStatus:mapStatus animated:YES duration:5.f];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.mapView addOverlay:self.cubeOverlay];
}

@end
