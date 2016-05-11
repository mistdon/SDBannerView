//
//  ViewController.m
//  SDAnimation
//
//  Created by shendong on 16/4/26.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "ViewController.h"
#import "AnimationView.h"

static CGFloat kLayerWidth = 50;

@interface ViewController ()

@property (nonatomic, strong) CALayer *movableCircleLayer;
@property (nonatomic, strong) UIView *oneview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    self.view.backgroundColor = [UIColor whiteColor];
    [self testBezierPath];
}
- (void)testBezierPath{
    UIImageView *iamge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    iamge.backgroundColor = [UIColor lightGrayColor];
    iamge.clipsToBounds = YES;
    iamge.layer.cornerRadius = 20;
    [self.view addSubview:iamge];
}
- (void)testLayer{
    //初始化
    self.movableCircleLayer = [CALayer layer];
    //设置大小。layer使用bounds，而不是frame来设置大小，因为frame不支持动画
    
    self.movableCircleLayer.bounds = CGRectMake(0, 0, kLayerWidth, kLayerWidth);
    //设置中心点，layer用position而不用center
    self.movableCircleLayer.position = self.view.center;
    self.movableCircleLayer.cornerRadius = kLayerWidth / 2;
    self.movableCircleLayer.backgroundColor = [UIColor blueColor].CGColor;
    self.movableCircleLayer.shadowColor = [UIColor greenColor].CGColor;
    self.movableCircleLayer.shadowOffset = CGSizeMake(3, 3);
    self.movableCircleLayer.shadowOpacity = 1;
    [self.view.layer addSublayer:self.movableCircleLayer];
    
    self.oneview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    self.oneview.center = self.view.center;
    self.oneview.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.oneview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    /*
    CGFloat width = kLayerWidth;
    
    if (self.movableCircleLayer.bounds.size.width <= kLayerWidth) {
        width = kLayerWidth * 2.5;
    }
    //
    self.movableCircleLayer.bounds = CGRectMake(0, 0, width, width);
    self.movableCircleLayer.position = [[touches anyObject] locationInView:self.view];
    self.movableCircleLayer.cornerRadius = width / 2;
    
    self.oneview.center = [[touches anyObject] locationInView:self.view];
    
    //通过点击时间可以看到,frame和bounds的区别，frame不带动画，bounds自带动画属性
     */
}
@end
