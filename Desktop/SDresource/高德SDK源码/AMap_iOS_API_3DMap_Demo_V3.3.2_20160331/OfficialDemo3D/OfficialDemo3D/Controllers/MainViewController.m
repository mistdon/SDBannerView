//
//  MainViewController.m
//  SearchV3Demo
//
//  Created by songjian on 13-8-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "MainViewController.h"
#import "BaseMapViewController.h"
#import "APIKey.h"

#define MainViewControllerTitle @"高德地图API-3D"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *classNames;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

@end

@implementation MainViewController
@synthesize titles      = _titles;
@synthesize classNames  = _classNames;
@synthesize tableView   = _tableView;

@synthesize mapView     = _mapView;
@synthesize search      = _search;

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"MAMapKit";
        case 1:
            return @"AMapSearchKit";
        case 2:
            return @"调起高德地图App";
        case 3:
            return @"云图搜索";
        case 4:
            return @"短串分享";
        default:
            return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainCellIdentifier = @"mainCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    
    cell.detailTextLabel.text = self.classNames[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = self.classNames[indexPath.section][indexPath.row];
    
    BaseMapViewController *subViewController = [[NSClassFromString(className) alloc] init];
    
    subViewController.title   = self.titles[indexPath.section][indexPath.row];
    subViewController.mapView = self.mapView;
    subViewController.search  = self.search;

    
    [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
}

#pragma mark - Initialization

- (void)initTitles
{
    NSArray *mapTitles = @[@"类型",
                           @"交通",
                           @"手势",
                           @"添加手势",
                           @"Overlay",
                           @"运动轨迹",
                           @"自定义Overlay",
                           @"自定义OpenGL绘制",
                           @"球面曲率Overlay",
                           @"Ground Overlay",
                           @"TileOverlay",
                           @"热力图",
                           @"Annotation",
                           @"自定义Annotation",
                           @"图片动画Annotation",
                           @"定位",
                           @"截屏",
                           @"离线地图",
                           @"TouchPoi",
                           @"Core Animation",
                           @"自定义定位样式",
                           @"多实例"];
    
    NSArray *searchTitles = @[@"POI",
                              @"路径规划",
                              @"输入提示",
                              @"地理编码",
                              @"逆地理编码",
                              @"公交路线",
                              @"公交站",
                              @"行政区域",
                              @"天气",
                              @"附近搜索"];
    

    NSArray *schemeTitles = @[@"在线导航", @"URL搜索"];
    
    NSArray *cloudSearchTitles = @[@"云图周边搜索",
                              @"云图polygon区域搜索",
                              @"云图ID搜索",
                              @"云图本地搜索"];
    
    NSArray *shareSearchTitles = @[@"位置分享",
                                   @"POI分享",
                                   @"路径分享",
                                   @"导航分享"];
    
    self.titles = [NSArray arrayWithObjects:mapTitles, searchTitles, schemeTitles, cloudSearchTitles, shareSearchTitles, nil];
}

- (void)initClassNames
{
    NSArray *mapClassNames = @[@"MapTypeViewController",
                               @"TrafficViewController",
                               @"GestureAttributesViewController",
                               @"AddGestureViewController",
                               @"OverlayViewController",
                               @"RunningLineViewController",
                               @"CustomOverlayViewController",
                               @"StereoOverlayViewController",
                               @"GeodesicViewController",
                               @"GroundOverlayViewController",
                               @"TileOverlayViewController",
                               @"HeatMapTileOverlayViewController",
                               @"AnnotationViewController",
                               @"CustomAnnotationViewController",
                               @"AnimatedAnnotationViewController",
                               @"UserLocationViewController",
                               @"ScreenshotViewController",
                               @"OfflineViewController",
                               @"TouchPoiViewController",
                               @"CoreAnimationViewController",
                               @"CustomUserLocationStyleViewController",
                               @"MultiMapViewController"];
    
    NSArray *searchClassNames = @[@"PoiViewController",
                                  @"RoutePlanningViewController",
                                  @"TipViewController",
                                  @"GeoViewController",
                                  @"InvertGeoViewController",
                                  @"BusLineViewController",
                                  @"BusStopViewController",
                                  @"DistrictViewController",
                                  @"WeatherViewController",
                                  @"NearbyVewController"];
    
    NSArray *schemeClassNames = @[@"OpenURLOnlineNavigationViewController",
                                  @"OpenAMapURLRequestViewController"];
    
    NSArray *cloudSearchClassNames = @[@"CloudPOIAroundSearchViewController",
                                       @"CloudPOIPolygonSearchViewController",
                                       @"CloudPOIIDSearchViewController",
                                       @"CloudPOILocalSearchViewController"];
    
    NSArray *shareSearchClassNames = @[@"LocationShareViewController",
                                       @"POIShareViewController",
                                       @"RouteShareViewController",
                                       @"NaviShareViewController"];
    
    self.classNames = [NSArray arrayWithObjects:mapClassNames, searchClassNames, schemeClassNames, cloudSearchClassNames, shareSearchClassNames, nil];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
}

/* 初始化search. */
- (void)initSearch
{
    [AMapSearchServices sharedServices].apiKey = (NSString *)APIKey;
    self.search = [[AMapSearchAPI alloc] init];
}

#pragma mark - Life Cycle

- (id)init
{
    if (self = [super init])
    {
        self.title = MainViewControllerTitle;
        
        /* 初始化search. */
        [self initSearch];
        
        
        [self initTitles];
        
        [self initClassNames];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableView];
    
    [self initMapView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle    = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController setToolbarHidden:YES animated:animated];
}

@end
