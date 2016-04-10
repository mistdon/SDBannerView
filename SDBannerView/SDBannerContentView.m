//
//  SDBannerContentView.m
//  SDBannerView
//
//  Created by Allen on 16/4/8.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "SDBannerContentView.h"

@implementation SDBannerContentView{
    UIImageView *imageView;
}
- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imageView];
    }
    return self;
}
- (void)imageOffsetValue:(float)value {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGRect centerToWindow    = [self convertRect:self.bounds toView:self.window];
    CGFloat centerX          = CGRectGetMidX(centerToWindow);
    CGPoint windowCenter     = self.window.center;
    CGFloat cellOffsetX      = centerX - windowCenter.x;
    CGAffineTransform transX = CGAffineTransformMakeTranslation(- cellOffsetX * value, 0);
    imageView.transform      = transX;
}
- (void)setImage:(UIImage *)image{
    imageView.image = image;
}

@end
