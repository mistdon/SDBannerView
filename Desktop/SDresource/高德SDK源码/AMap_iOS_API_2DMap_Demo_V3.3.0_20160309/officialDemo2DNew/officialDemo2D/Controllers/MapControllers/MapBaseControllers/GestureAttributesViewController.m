//
//  GestureAttributesViewController.m
//  Category_demo
//
//  Created by songjian on 13-3-21.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "GestureAttributesViewController.h"

enum{
    GestureAttributesViewControllerTagScroll = 0,
    GestureAttributesViewControllerTagZoom
};

#define ScrollTitle(enabled) ((enabled) ? (@"Scroll D") : (@"Scroll E"))
#define ZoomTitle(enabled)   ((enabled) ? (@"Zoom D")   : (@"Zoom E"))

@interface GestureAttributesViewController ()

@end

@implementation GestureAttributesViewController

#pragma mark - Action Handle

- (void)gestureAttributesAction:(UIBarButtonItem *)item
{
    switch (item.tag)
    {
        case GestureAttributesViewControllerTagScroll:
        {
            self.mapView.scrollEnabled = !self.mapView.scrollEnabled;
            
            item.title = ScrollTitle(self.mapView.scrollEnabled);
            
            break;
        }
        case GestureAttributesViewControllerTagZoom:
        {
            self.mapView.zoomEnabled = !self.mapView.zoomEnabled;
            
            item.title = ZoomTitle(self.mapView.zoomEnabled);
            
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark - Initialization

- (void)initToolBar
{
    UIBarButtonItem *flexbleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                 target:self
                                                                                 action:nil];
    
    UIBarButtonItem *scrollItem = [[UIBarButtonItem alloc] initWithTitle:ScrollTitle(YES)
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(gestureAttributesAction:)];
    scrollItem.tag = GestureAttributesViewControllerTagScroll;
    
    UIBarButtonItem *zoomItem = [[UIBarButtonItem alloc] initWithTitle:ZoomTitle(YES)
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(gestureAttributesAction:)];
    zoomItem.tag = GestureAttributesViewControllerTagZoom;
    
    self.toolbarItems = [NSArray arrayWithObjects:flexbleItem, scrollItem, flexbleItem, zoomItem, flexbleItem, nil];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initToolBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.toolbar.barStyle      = UIBarStyleBlack;
    self.navigationController.toolbar.translucent   = YES;
    [self.navigationController setToolbarHidden:NO animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    /* Reset gesture attributes. */
    self.mapView.scrollEnabled       = YES;
    self.mapView.zoomEnabled         = YES;
}

@end
