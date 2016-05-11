//
//  SecondViewController.m
//  SDAnimation
//
//  Created by shendong on 16/4/26.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "SecondViewController.h"

static CGFloat const kPhotoWidth = 100;

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawImage];
}
/**
 *  被塞尔曲线
 */
- (void)drawbezierpath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
}
- (void)drawImage{
    CALayer *layer      = [CALayer layer];
    layer.bounds        = CGRectMake(0, 0, kPhotoWidth, kPhotoWidth);
    layer.position      = self.view.center;
    layer.cornerRadius  = kPhotoWidth  / 2;
    //设置次属性后，可以对sublayer进行裁剪，将其裁剪成圆形。
    layer.masksToBounds = YES;
    layer.borderColor   = [UIColor yellowColor].CGColor;
    layer.borderWidth   = 1.0f;
    
    //将masksToBounds设置为YES后，shadow相关属性不再起总用.原因是masksToBounds的作用就是防止子视图溢出。
//    layer.shadowColor = [UIColor blueColor].CGColor;
//    layer.shadowOffset = CGSizeMake(4, 4);
//    layer.shadowOpacity = 0.9;
       
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"cutecat"].CGImage);
    [self.view.layer addSublayer:layer];
    
    
    //因此，需手动添加阴影效果
    CALayer *shadowLayer      = [CALayer layer];
    shadowLayer.position      = layer.position;
    shadowLayer.bounds        = layer.bounds;
    shadowLayer.cornerRadius  = layer.cornerRadius;
    shadowLayer.shadowOpacity = 1.0;
    shadowLayer.shadowColor   = [UIColor redColor].CGColor;
    shadowLayer.shadowOffset  = CGSizeMake(5, 5);
    shadowLayer.borderWidth   = layer.borderWidth;
    shadowLayer.borderColor   = [UIColor whiteColor].CGColor;
    [self.view.layer insertSublayer:shadowLayer below:layer];
    
//    [layer setNeedsDisplay];
}
#pragma mark - CALayer delegate
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    //注意: 坐标系统和view的frame/bounds不同, 此处为笛卡尔坐标体系，即左下角为{0,0}
    
}
@end
