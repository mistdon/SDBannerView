//
//  RunningLineViewController.m
//  DevDemo3D
//
//  Created by yi chen on 12/11/15.
//  Copyright © 2015 yi chen. All rights reserved.
//

#import "RunningLineViewController.h"

@implementation RunningLineViewController
{
    NSMutableArray * _speedColors;
    CLLocationCoordinate2D * _runningCoords;
    NSUInteger _count;
    
    MAMultiPolyline * _polyline;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if (overlay == _polyline)
    {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        
        polylineRenderer.lineWidth = 8.f;
        polylineRenderer.strokeColors = _speedColors;
        polylineRenderer.gradient = YES;
        
        return polylineRenderer;

    }

    return nil;
}

- (UIColor *)getColorForSpeed:(float)speed
{
    const float lowSpeedTh = 2.f;
    const float highSpeedTh = 3.5f;
    const CGFloat warmHue = 0.02f; //偏暖色
    const CGFloat coldHue = 0.4f; //偏冷色
    
    float hue = coldHue - (speed - lowSpeedTh)*(coldHue - warmHue)/(highSpeedTh - lowSpeedTh);
    return [UIColor colorWithHue:hue saturation:1.f brightness:1.f alpha:1.f];
}

- (void)initData
{
    _speedColors = [NSMutableArray array];
    
    NSData *jsdata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"running_record" ofType:@"json"]];
    
    NSMutableArray * indexes = [NSMutableArray array];
    if (jsdata)
    {
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsdata options:NSJSONReadingAllowFragments error:nil];
        
        _count = dataArray.count;
        _runningCoords = (CLLocationCoordinate2D *)malloc(_count * sizeof(CLLocationCoordinate2D));
        
        for (int i = 0; i < _count; i++)
        {
            @autoreleasepool
            {
                NSDictionary * data = dataArray[i];
                _runningCoords[i].latitude = [data[@"latitude"] doubleValue];
                _runningCoords[i].longitude = [data[@"longtitude"] doubleValue];
                
                UIColor * speedColor = [self getColorForSpeed:[data[@"speed"] floatValue]];
                [_speedColors addObject:speedColor];
                
                [indexes addObject:@(i)];
            }
        }
    }
    
    _polyline = [MAMultiPolyline polylineWithCoordinates:_runningCoords count:_count drawStyleIndexes:indexes];

}

#pragma mark 

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mapView addOverlay:_polyline];
    
    const CGFloat screenEdgeInset = 20;
    UIEdgeInsets inset = UIEdgeInsetsMake(screenEdgeInset, screenEdgeInset, screenEdgeInset, screenEdgeInset);
    [self.mapView setVisibleMapRect:_polyline.boundingMapRect edgePadding:inset animated:NO];
}

#pragma mark - Life Cycle

- (id)init
{
    if (self = [super init])
    {
        [self initData];
    }
    return self;
}

- (void)dealloc
{
    if (_runningCoords)
    {
        free(_runningCoords);
        _count = 0;
    }
}
@end
