//
//  SDSViewController.m
//  SPC330
//
//  Created by shendong on 16/5/9.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "SDSViewController.h"
#import "SDTabBarController.h"

@interface SDSViewController ()

//@property (nonatomic, strong) SDTabBarController *tabBarViewController;
@property (nonatomic, strong) UINavigationController *homeNavgaitonController;
@property (nonatomic, strong) UIColor *backgroundColor;  //背景颜色
//@property (nonatomic, strong) SDTabBarController *centralTabBarViewController;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, assign) CGPoint centerOfLeftViewAtBeginning;

@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) CGFloat fullDistance;
//@property (nonatomic, assign) CGFloat distance;
//@property (nonatomic, assign) CGFloat distance;


@end

@implementation SDSViewController
- (instancetype)initWithCenteralViewController:(UINavigationController *)centralViewController left:(UIViewController *)leftViewController{
    self = [super init];
    if (self) {
        _centralNavigationViewController = centralViewController;
        _leftViewController              = leftViewController;
        _distance = 0.f;
        _fullDistance = 0.78f;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. backgrund view
    self.view.backgroundColor = [UIColor lightGrayColor];

    
    //2.add left vc's view
    self.leftViewController.view.center = CGPointMake(self.leftViewController.view.center.x - 50, self.leftViewController.view.center.y);
//    self.leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    self.centerOfLeftViewAtBeginning = self.leftViewController.view.center;
    [self.view addSubview:self.leftViewController.view];
    
    //3. add cover view
    
    //4. set mainview
    
    self.mainView = [[UIView alloc] initWithFrame:self.view.frame];
 
//    //1.设置mainView
    [self.mainView addSubview:self.centralNavigationViewController.view];
    [self.view addSubview:self.mainView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(contentCentralViewPanGestureAction:)];
    [self.mainView addGestureRecognizer:pan];
    
//        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(leftClicked:)];
//    self.tabBarController.navigationItem.leftBarButtonItem = left;
    
}
- (void)leftClicked:(UIBarButtonItem *)sender{
    [self showleft];
}
- (void)showleft{
    NSLog(@"%s",__func__);
}
- (void)showCentral{
   NSLog(@"%s",__func__);
}
- (void)contentCentralViewPanGestureAction:(UIPanGestureRecognizer *)gesture{
    CGPoint temp = [gesture locationInView:self.mainView];
    CGFloat trueDistance = temp.x + _distance;
    NSLog(@"trueDistance = %lf",trueDistance);
}

@end
