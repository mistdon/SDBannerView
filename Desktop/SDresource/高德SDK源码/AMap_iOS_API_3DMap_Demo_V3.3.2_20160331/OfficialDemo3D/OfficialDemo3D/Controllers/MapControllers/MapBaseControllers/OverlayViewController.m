//
//  OverlayViewController.m
//  Category_demo
//
//  Created by songjian on 13-3-21.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "OverlayViewController.h"

enum{
    OverlayViewControllerOverlayTypeCommonPolyline = 0,
    OverlayViewControllerOverlayTypePolygon,
    OverlayViewControllerOverlayTypeTexturePolyline,
    OverlayViewControllerOverlayTypeArrowPolyline,
    OverlayViewControllerOverlayTypeMultiTexPolyline,
    OverlayViewControllerOverlayTypeMultiColoredPolyline,
    OverlayViewControllerOverlayTypeGradientColoredPolyline
};

@interface OverlayViewController ()

@property (nonatomic, strong) NSMutableArray *overlaysAboveRoads;

@property (nonatomic, strong) NSMutableArray *overlaysAboveLabels;

@end

@implementation OverlayViewController
@synthesize overlaysAboveRoads  = _overlaysAboveRoads;
@synthesize overlaysAboveLabels = _overlaysAboveLabels;

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        circleRenderer.lineWidth    = 5.f;
        circleRenderer.strokeColor  = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        circleRenderer.fillColor    = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:0.8];
        circleRenderer.lineDash     = YES;
        
        return circleRenderer;
    }
    else if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonRenderer *polygonRenderer = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polygonRenderer.lineWidth    = 5.f;
        polygonRenderer.strokeColor  = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        polygonRenderer.fillColor    = [UIColor colorWithRed:0.77 green:0.88 blue:0.94 alpha:0.8];
        polygonRenderer.lineJoinType = kMALineJoinMiter;
        
        return polygonRenderer;
    }
    else if([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        if (overlay == self.overlaysAboveLabels[OverlayViewControllerOverlayTypeMultiTexPolyline])
        {
            MAMultiTexturePolylineRenderer * polylineRenderer = [[MAMultiTexturePolylineRenderer alloc] initWithMultiPolyline:overlay];
            polylineRenderer.lineWidth    = 18.f;
            
            UIImage * bad = [UIImage imageNamed:@"custtexture_bad"];
            UIImage * slow = [UIImage imageNamed:@"custtexture_slow"];
            UIImage * green = [UIImage imageNamed:@"custtexture_green"];
            
            BOOL succ = [polylineRenderer loadStrokeTextureImages:@[bad, slow, green]];
            if (!succ)
            {
                NSLog(@"loading texture image fail.");
            }
            return polylineRenderer;
            
        }
        else
        {
            MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
            
            polylineRenderer.lineWidth = 8.f;
            polylineRenderer.strokeColors = @[[UIColor redColor], [UIColor greenColor], [UIColor yellowColor]];
            
            if(overlay == self.overlaysAboveLabels[OverlayViewControllerOverlayTypeMultiColoredPolyline])
            {
                polylineRenderer.gradient = NO;
            }
            else if(overlay == self.overlaysAboveLabels[OverlayViewControllerOverlayTypeGradientColoredPolyline])
            {
                polylineRenderer.gradient = YES;
            }
            
            return polylineRenderer;
            
        }
        
    }
    else if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];

        if (overlay == self.overlaysAboveLabels[OverlayViewControllerOverlayTypeTexturePolyline])
        {
            polylineRenderer.lineWidth    = 8.f;
            [polylineRenderer loadStrokeTextureImage:[UIImage imageNamed:@"arrowTexture"]];
            
        }
        else if(overlay == self.overlaysAboveLabels[OverlayViewControllerOverlayTypeArrowPolyline])
        {
            polylineRenderer.lineWidth    = 20.f;
            polylineRenderer.lineCapType  = kMALineCapArrow;
        }
        else
        {
            polylineRenderer.lineWidth    = 8.f;
            polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
            polylineRenderer.lineJoinType = kMALineJoinRound;
            polylineRenderer.lineCapType  = kMALineCapRound;
        }
        
        return polylineRenderer;
    }
    
    return nil;
}

#pragma mark - Helpers
/*!
 @brief  生成多角星坐标
 @param coordinates 输出的多角星坐标数组指针。内存需在外申请，方法内不释放，多角星坐标结果输出。
 @param pointsCount 输出的多角星坐标数组元素个数。
 @param starCenter  多角星的中心点位置。
 */
- (void)generateStarPoints:(CLLocationCoordinate2D *)coordinates pointsCount:(NSUInteger)pointsCount atCenter:(CLLocationCoordinate2D)starCenter
{
#define STAR_RADIUS 0.05
#define PI 3.1415926
    NSUInteger starRaysCount = pointsCount / 2;
    for (int i =0; i<starRaysCount; i++)
    {
        float angle = 2.f*i/starRaysCount*PI;
        int index = 2 * i;
        coordinates[index].latitude = STAR_RADIUS* sin(angle) + starCenter.latitude;
        coordinates[index].longitude = STAR_RADIUS* cos(angle) + starCenter.longitude;
        
        index++;
        angle = angle + (float)1.f/starRaysCount*PI;
        coordinates[index].latitude = STAR_RADIUS/2.f* sin(angle) + starCenter.latitude;
        coordinates[index].longitude = STAR_RADIUS/2.f* cos(angle) + starCenter.longitude;
    }
    
}

#pragma mark - Initialization

- (void)initOverlays
{
    self.overlaysAboveLabels = [NSMutableArray array];
    self.overlaysAboveRoads = [NSMutableArray array];
    
    /* Circle. */
    MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(39.952136, 116.50095) radius:5000];
    [self.overlaysAboveRoads addObject:circle];
    
    /* Polyline. */
    CLLocationCoordinate2D commonPolylineCoords[5];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;
    
    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;
    
    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;
    
    commonPolylineCoords[3].latitude = 39.902136;
    commonPolylineCoords[3].longitude = 116.44095;
    
    commonPolylineCoords[4].latitude = 39.932136;
    commonPolylineCoords[4].longitude = 116.44095;
    
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:5];
    [self.overlaysAboveLabels insertObject:commonPolyline atIndex:OverlayViewControllerOverlayTypeCommonPolyline];

    /* Polygon. */
#define STAR_RAYS_COUNT 5 //绘制多角星。 STAR_RAYS_COUNT为5时即为五角星
    CLLocationCoordinate2D coordinates[STAR_RAYS_COUNT * 2];
    [self generateStarPoints:coordinates pointsCount:STAR_RAYS_COUNT * 2 atCenter:CLLocationCoordinate2DMake(39.800892, 116.293413)];//生成多角星的坐标
    MAPolygon *polygon = [MAPolygon polygonWithCoordinates:coordinates count:STAR_RAYS_COUNT * 2];
    [self.overlaysAboveLabels insertObject:polygon atIndex:OverlayViewControllerOverlayTypePolygon];
    
    /* Textured Polyline. */
    CLLocationCoordinate2D texPolylineCoords[3];
    texPolylineCoords[0].latitude = 39.932136;
    texPolylineCoords[0].longitude = 116.44095;
    
    texPolylineCoords[1].latitude = 39.932136;
    texPolylineCoords[1].longitude = 116.50095;
    
    texPolylineCoords[2].latitude = 39.952136;
    texPolylineCoords[2].longitude = 116.50095;
    
    MAPolyline *texPolyline = [MAPolyline polylineWithCoordinates:texPolylineCoords count:3];
    [self.overlaysAboveLabels insertObject:texPolyline atIndex:OverlayViewControllerOverlayTypeTexturePolyline];
    
    /* Arrow Polyline. */
    CLLocationCoordinate2D ArrowPolylineCoords[3];
    ArrowPolylineCoords[0].latitude = 39.793765;
    ArrowPolylineCoords[0].longitude = 116.294653;
    
    ArrowPolylineCoords[1].latitude = 39.831741;
    ArrowPolylineCoords[1].longitude = 116.294653;
    
    ArrowPolylineCoords[2].latitude = 39.832136;
    ArrowPolylineCoords[2].longitude = 116.34095;
    
    MAPolyline *arrowPolyline = [MAPolyline polylineWithCoordinates:ArrowPolylineCoords count:3];
    [self.overlaysAboveLabels insertObject:arrowPolyline atIndex:OverlayViewControllerOverlayTypeArrowPolyline];

    /* Multi-Texture Polyline. */
    CLLocationCoordinate2D mulTexPolylineCoords[5];
    mulTexPolylineCoords[0].latitude = 39.852136;
    mulTexPolylineCoords[0].longitude = 116.30095;
    
    mulTexPolylineCoords[1].latitude = 39.852136;
    mulTexPolylineCoords[1].longitude = 116.40095;
    
    mulTexPolylineCoords[2].latitude = 39.932136;
    mulTexPolylineCoords[2].longitude = 116.40095;
    
    mulTexPolylineCoords[3].latitude = 39.932136;
    mulTexPolylineCoords[3].longitude = 116.40095;
    
    mulTexPolylineCoords[4].latitude = 39.982136;
    mulTexPolylineCoords[4].longitude = 116.48095;
    
    MAMultiPolyline *multiTexturePolyline = [MAMultiPolyline polylineWithCoordinates:mulTexPolylineCoords count:5 drawStyleIndexes:@[@1, @2, @4]];
    [self.overlaysAboveLabels insertObject:multiTexturePolyline atIndex:OverlayViewControllerOverlayTypeMultiTexPolyline];
    
    /* Multi-Colored Polyline. */
    CLLocationCoordinate2D coloredPolylineCoords[5];
    coloredPolylineCoords[0].latitude = 39.802136;
    coloredPolylineCoords[0].longitude = 116.36095;
    
    coloredPolylineCoords[1].latitude = 39.802136;
    coloredPolylineCoords[1].longitude = 116.43095;
    
    coloredPolylineCoords[2].latitude = 39.882136;
    coloredPolylineCoords[2].longitude = 116.43095;
    
    coloredPolylineCoords[3].latitude = 39.882136;
    coloredPolylineCoords[3].longitude = 116.45095;
    
    coloredPolylineCoords[4].latitude = 39.902136;
    coloredPolylineCoords[4].longitude = 116.45095;
    
    MAMultiPolyline *coloredPolyline = [MAMultiPolyline polylineWithCoordinates:coloredPolylineCoords count:5 drawStyleIndexes:@[@1, @2, @4]];
    [self.overlaysAboveLabels insertObject:coloredPolyline atIndex:OverlayViewControllerOverlayTypeMultiColoredPolyline];
    
    /* Gradient Colored Polyline. */
    CLLocationCoordinate2D gradientPolylineCoords[5];
    gradientPolylineCoords[0].latitude = 39.782136;
    gradientPolylineCoords[0].longitude = 116.38095;
    
    gradientPolylineCoords[1].latitude = 39.782136;
    gradientPolylineCoords[1].longitude = 116.46095;
    
    gradientPolylineCoords[2].latitude = 39.852136;
    gradientPolylineCoords[2].longitude = 116.46095;
    
    gradientPolylineCoords[3].latitude = 39.852136;
    gradientPolylineCoords[3].longitude = 116.48095;
    
    gradientPolylineCoords[4].latitude = 39.882136;
    gradientPolylineCoords[4].longitude = 116.48095;
    
    MAMultiPolyline *gradientColoredPolyline = [MAMultiPolyline polylineWithCoordinates:gradientPolylineCoords count:5 drawStyleIndexes:@[@1, @2, @3]];
    [self.overlaysAboveLabels insertObject:gradientColoredPolyline atIndex:OverlayViewControllerOverlayTypeGradientColoredPolyline];

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
    
    [self.mapView addOverlays:self.overlaysAboveLabels];
    [self.mapView addOverlays:self.overlaysAboveRoads level:MAOverlayLevelAboveRoads];
}

@end
