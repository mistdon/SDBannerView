//
//  MultiMapViewController.m
//  OfficialDemo3D
//
//  Created by 翁乐 on 11/6/15.
//  Copyright © 2015 songjian. All rights reserved.
//

#import "MultiMapViewController.h"

@interface MultiMapViewController()
{
    MAMapView *_mapview2;
}

@end

@implementation MultiMapViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect2 = CGRectMake(self.mapView.frame.origin.x, self.view.frame.origin.y + self.view.frame.size.height / 2.0, self.view.frame.size.width, self.view.frame.size.height / 2.0);
    _mapview2 = [[MAMapView alloc] initWithFrame:rect2];
    
    
    CGRect rect1 = CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.origin.y, self.mapView.frame.size.width, self.mapView.frame.size.height / 2.0);
    self.mapView.frame = rect1;
    
    [self.view addSubview:_mapview2];
    
}
@end
