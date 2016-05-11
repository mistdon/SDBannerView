//
//  TileOverlayViewController.m
//  OfficialDemo3D
//
//  Created by Li Fei on 3/3/14.
//  Copyright (c) 2014 songjian. All rights reserved.
//

#import "TileOverlayViewController.h"
#import "LocalTileOverlay.h"

#define kTileOverlayRemoteServerTemplate @"http://cache1.arcgisonline.cn/arcgis/rest/services/ChinaCities_Community_BaseMap_ENG/BeiJing_Community_BaseMap_ENG/MapServer/tile/{z}/{y}/{x}"

#define kTileOverlayRemoteMinZ      4
#define kTileOverlayRemoteMaxZ      17

#define kTileOverlayLocalMinZ       11
#define kTileOverlayLocalMaxZ       13

@interface TileOverlayViewController ()

@property (nonatomic, strong) MATileOverlay *tileOverlay;

@property (nonatomic, assign) NSInteger type; // 0 local; 1 remote

@end

@implementation TileOverlayViewController

@synthesize tileOverlay = _tileOverlay;
@synthesize type        = _type;

#pragma mark - Utility

/* 根据type构建对应的MATileOverlay. */
- (MATileOverlay *)constructTileOverlayWithType:(NSInteger)type
{
    MATileOverlay *tileOverlay = nil;
    if (type == 0)
    {
        tileOverlay = [[LocalTileOverlay alloc] init];
        tileOverlay.minimumZ = kTileOverlayLocalMinZ;
        tileOverlay.maximumZ = kTileOverlayLocalMaxZ;
    }
    else // type == 1
    {
        tileOverlay = [[MATileOverlay alloc] initWithURLTemplate:kTileOverlayRemoteServerTemplate];
        
        /* minimumZ 是tileOverlay的可见最小Zoom值. */
        tileOverlay.minimumZ = kTileOverlayRemoteMinZ;
        /* minimumZ 是tileOverlay的可见最大Zoom值. */
        tileOverlay.maximumZ = kTileOverlayRemoteMaxZ;
        
        /* boundingMapRect 是用来 设定tileOverlay的可渲染区域. */
        tileOverlay.boundingMapRect = MAMapRectWorld;
    }
    
    return tileOverlay;
}

/* 切换图层. */
- (void)changeToType:(NSInteger)type
{
    /* 删除之前的图层. */
    [self.mapView removeOverlay:self.tileOverlay];
    
    /* 添加新的图层. */
    self.tileOverlay = [self constructTileOverlayWithType:type];
    [self.mapView addOverlay:self.tileOverlay];
}

#pragma mark - MKMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MATileOverlay class]])
    {
        MATileOverlayRenderer *tileOverlayRenderer = [[MATileOverlayRenderer alloc] initWithTileOverlay:overlay];
        
        return tileOverlayRenderer;
    }
    
    return nil;
}

#pragma mark - Handle Action

- (void)changeTypeAction:(UISegmentedControl *)segmentedControl
{
    self.type = segmentedControl.selectedSegmentIndex;
    
    [self changeToType:self.type];
}

#pragma mark - initialization

- (void)initToolBar
{
    UIBarButtonItem *flexbleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                 target:self
                                                                                 action:nil];
    
    UISegmentedControl *floorSegmentedControl = [[UISegmentedControl alloc] initWithItems:
                                                 [NSArray arrayWithObjects:
                                                  @"local",
                                                  @"remote",
                                                  nil]];
    floorSegmentedControl.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 100, 40);
    floorSegmentedControl.selectedSegmentIndex  = self.type;
    floorSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [floorSegmentedControl addTarget:self action:@selector(changeTypeAction:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *floorItem = [[UIBarButtonItem alloc] initWithCustomView:floorSegmentedControl];
    
    self.toolbarItems = [NSArray arrayWithObjects:flexbleItem, floorItem, flexbleItem, nil];
}

#pragma mark - Life Cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        self.type = 0;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initToolBar];
    
    self.mapView.zoomLevel          = kTileOverlayLocalMaxZ;
    
    [self changeToType:self.type];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.toolbar.barStyle      = UIBarStyleBlack;
    self.navigationController.toolbar.translucent   = YES;
    [self.navigationController setToolbarHidden:NO animated:animated];
}

@end
