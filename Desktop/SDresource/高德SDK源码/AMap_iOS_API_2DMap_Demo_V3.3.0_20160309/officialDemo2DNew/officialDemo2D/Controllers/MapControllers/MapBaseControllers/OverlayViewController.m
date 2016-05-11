//
//  OverlayViewController.m
//  Category_demo
//
//  Created by songjian on 13-3-21.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "OverlayViewController.h"

enum{
    OverlayViewControllerOverlayTypeCircle = 0,
    OverlayViewControllerOverlayTypePolygon,
    OverlayViewControllerOverlayTypePolyline,
    OverlayViewControllerOverlayTypeColoredPolyline,
    OverlayViewControllerOverlayTypeGradientPolyline
};

@interface OverlayViewController ()

@property (nonatomic, strong) NSMutableArray *overlays;

@end

@implementation OverlayViewController
@synthesize overlays = _overlays;

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        circleRenderer.lineWidth   = 4.f;
        circleRenderer.strokeColor = [UIColor blueColor];
        circleRenderer.fillColor   = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:.3];
        
        return circleRenderer;
    }
    else if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonRenderer *polygonRenderer = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polygonRenderer.lineWidth   = 4.f;
        polygonRenderer.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        polygonRenderer.fillColor   = [UIColor redColor];
        
        return polygonRenderer;
    }
    else if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        
        polylineRenderer.lineWidth = 10.f;
        
        if (overlay == self.overlays[OverlayViewControllerOverlayTypeGradientPolyline])
        {
            polylineRenderer.strokeColors = @[[UIColor blueColor], [UIColor whiteColor], [UIColor blackColor], [UIColor greenColor]];
            polylineRenderer.gradient = YES;
        }
        else
        {
            polylineRenderer.strokeColors = @[[UIColor redColor], [UIColor yellowColor], [UIColor greenColor]];
            polylineRenderer.gradient = NO;
        }
        
        return polylineRenderer;
    }
    else if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth   = 4.f;
        polylineRenderer.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        polylineRenderer.lineDashPhase = 10;
        polylineRenderer.lineDashPattern = @[@(10), @(10)];
        return polylineRenderer;
    }
    
    return nil;
}

#pragma mark - Initialization

- (void)initOverlays
{
    self.overlays = [NSMutableArray array];
    
    /* Circle. */
    MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(39.996441, 116.411146) radius:15000];
    [self.overlays insertObject:circle atIndex:OverlayViewControllerOverlayTypeCircle];
    
    /* Polygon. */
    CLLocationCoordinate2D coordinates[4];
    coordinates[0].latitude = 39.781892;
    coordinates[0].longitude = 116.293413;
    
    coordinates[1].latitude = 39.787600;
    coordinates[1].longitude = 116.391842;
    
    coordinates[2].latitude = 39.733187;
    coordinates[2].longitude = 116.417932;
    
    coordinates[3].latitude = 39.704653;
    coordinates[3].longitude = 116.338255;
    MAPolygon *polygon = [MAPolygon polygonWithCoordinates:coordinates count:4];
    [self.overlays insertObject:polygon atIndex:OverlayViewControllerOverlayTypePolygon];
    
    /* Polyline. */
    CLLocationCoordinate2D polylineCoords[4];
    polylineCoords[0].latitude = 39.855539;
    polylineCoords[0].longitude = 116.419037;
    
    polylineCoords[1].latitude = 39.858172;
    polylineCoords[1].longitude = 116.520285;
    
    polylineCoords[2].latitude = 39.795479;
    polylineCoords[2].longitude = 116.520859;
    
    polylineCoords[3].latitude = 39.788467;
    polylineCoords[3].longitude = 116.426786;
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:polylineCoords count:4];
    [self.overlays insertObject:polyline atIndex:OverlayViewControllerOverlayTypePolyline];
    
    /* Colored Polyline. */
    CLLocationCoordinate2D coloredPolylineCoords[5];
    coloredPolylineCoords[0].latitude = 39.938698;
    coloredPolylineCoords[0].longitude = 116.275177;
    
    coloredPolylineCoords[1].latitude = 39.966069;
    coloredPolylineCoords[1].longitude = 116.289253;
    
    coloredPolylineCoords[2].latitude = 39.944226;
    coloredPolylineCoords[2].longitude = 116.306076;
    
    coloredPolylineCoords[3].latitude = 39.966069;
    coloredPolylineCoords[3].longitude = 116.322899;
    
    coloredPolylineCoords[4].latitude = 39.938698;
    coloredPolylineCoords[4].longitude = 116.336975;

    MAMultiPolyline *coloredPolyline = [MAMultiPolyline polylineWithCoordinates:coloredPolylineCoords count:5 drawStyleIndexes:@[@1, @3]];
    [self.overlays insertObject:coloredPolyline atIndex:OverlayViewControllerOverlayTypeColoredPolyline];
    
    /* Gradient Polyline. */
    CLLocationCoordinate2D gradientPolylineCoords[8];
    gradientPolylineCoords[0].latitude = 39.938698;
    gradientPolylineCoords[0].longitude = 116.351051;
    
    gradientPolylineCoords[1].latitude = 39.966069;
    gradientPolylineCoords[1].longitude = 116.366844;
    
    gradientPolylineCoords[2].latitude = 39.938698;
    gradientPolylineCoords[2].longitude = 116.381264;
    
    gradientPolylineCoords[3].latitude = 39.938698;
    gradientPolylineCoords[3].longitude = 116.395683;
    
    gradientPolylineCoords[4].latitude = 39.950067;
    gradientPolylineCoords[4].longitude = 116.395683;
    
    gradientPolylineCoords[5].latitude = 39.950437;
    gradientPolylineCoords[5].longitude = 116.423449;
    
    gradientPolylineCoords[6].latitude = 39.966069;
    gradientPolylineCoords[6].longitude = 116.423449;
    
    gradientPolylineCoords[7].latitude = 39.966069;
    gradientPolylineCoords[7].longitude = 116.395683;

    MAMultiPolyline *gradientPolyline = [MAMultiPolyline polylineWithCoordinates:gradientPolylineCoords count:8 drawStyleIndexes:@[@0, @2, @3, @7]];
    [self.overlays insertObject:gradientPolyline atIndex:OverlayViewControllerOverlayTypeGradientPolyline];

}

#pragma mark - Life Cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initOverlays];
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mapView addOverlays:self.overlays];
}

@end
