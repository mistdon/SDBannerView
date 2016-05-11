//
//  AnimationView.m
//  SDAnimation
//
//  Created by shendong on 16/4/27.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "AnimationView.h"
#import <math.h>
//#define kDegreeToRadians(degress) ((3.1415926 * degress)/ 180)


@implementation AnimationView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //绘制三角形
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(10, 10)];
//    [path addLineToPoint:CGPointMake(100, 100)];
//    [path addLineToPoint:CGPointMake(20, 50)];
//    [path closePath];
//    
//    path.lineWidth = 2.0f;
//    [[UIColor greenColor] setStroke];
//    [[UIColor redColor] setFill];
//    [path stroke];
//    [path fill];
    
    //带圆角的矩形
//    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:50];
//    [path1 addClip];
//    path1.lineWidth = 25;
//    path1.lineCapStyle = kCGLineCapRound;
//    path1.lineJoinStyle = kCGLineJoinRound;
//    [[UIColor greenColor] setFill];
//    [[UIColor redColor] setStroke];
//
//    [path1 fill];
//    [path1 stroke];
    
    
      //指定圆角的矩形
//    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(50, 50)];
//    [path1 addClip];
//    path1.lineWidth = 25;
//    path1.lineCapStyle = kCGLineCapRound;
//    path1.lineJoinStyle = kCGLineJoinRound;
//    [[UIColor greenColor] setFill];
//    [[UIColor redColor] setStroke];
//
//    [path1 fill];
//    [path1 stroke];
    
    //根据矩形画圆
//    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, self.bounds.size.width - 100, self.bounds.size.height - 40)];
//    path2.lineWidth     = 20.0f;
//    [[UIColor greenColor] setFill];
//    [[UIColor grayColor] setStroke];
//    [path2 stroke];
//    [path2 fill];
    
    
    //画圆弧
    CGPoint center      = self.center;
    CGFloat endEndge = M_PI;
    NSLog(@"endEndge = %lf",endEndge);
    UIBezierPath *path5 = [UIBezierPath bezierPathWithArcCenter:center radius:50 startAngle:0 endAngle: (135 * M_PI)/180 clockwise:YES];NSLog(@"m_PI = %lf",M_PI);
    path5.lineCapStyle  = kCGLineCapRound;
    path5.lineJoinStyle = kCGLineJoinRound;
    path5.lineWidth     = 10;
    [[UIColor redColor] set];
    [path5 stroke];
    [self drawARCPath];
}

#define   kDegreesToRadians(degrees)  ((pi * degrees)/ 180)
- (void)drawARCPath {
    const CGFloat pi = 3.14159265359;
    
    
    CGFloat endEndge = kDegreesToRadians(135);
    NSLog(@"endEndge = %lf",endEndge);
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:100
                                                    startAngle:0
                                                      endAngle:kDegreesToRadians(135)
                                                     clockwise:NO];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    
    [path stroke];
}
@end
