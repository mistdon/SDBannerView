//
//  GroundOverlayViewController.m
//  OfficialDemo3D
//
//  Created by songjian on 13-11-19.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "GroundOverlayViewController.h"

@interface GroundOverlayViewController ()

@property (nonatomic, strong) MAGroundOverlay *groundOverlay;

@end

@implementation GroundOverlayViewController
@synthesize groundOverlay = _groundOverlay;

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAGroundOverlay class]])
    {
        MAGroundOverlayRenderer *groundOverlayRenderer = [[MAGroundOverlayRenderer alloc] initWithGroundOverlay:overlay];
        
        return groundOverlayRenderer;
    }
    
    return nil;
}

#pragma mark - initialization

- (void)initGroundOverlay
{
    MACoordinateBounds coordinateBounds = MACoordinateBoundsMake(CLLocationCoordinate2DMake(39.939577, 116.388331),
                                                                 CLLocationCoordinate2DMake(39.935029, 116.384377));
    
    self.groundOverlay = [MAGroundOverlay groundOverlayWithBounds:coordinateBounds icon:[UIImage imageNamed:@"GWF"]];
}

#pragma mark - Life Cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initGroundOverlay];
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.mapView addOverlay:self.groundOverlay];
    
    self.mapView.visibleMapRect = self.groundOverlay.boundingMapRect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

@end
