//
//  ViewController.m
//  SDBannerView
//
//  Created by shendong on 2017/3/6.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "ViewController.h"
#import <SDBannerView/SDBannerView.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SDBannerView *bottomBannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (int i = 1; i < 5; i++) {
//        [array addObject:[NSString stringWithFormat:@"%1d.jpg",i]];
//    };
//    [array addObject:@"http://ww4.sinaimg.cn/large/0060lm7Tgy1fd9vesjrpsj30dw0kuacd.jpg"];
//    [array addObject:@"http://ww4.sinaimg.cn/large/0060lm7Tgy1fd9vbzh431j30dw0j9mzm.jpg"];
//    [array addObject:@"http://pic72.nipic.com/file/20150716/21422793_144600530000_2.jpg"];
//    SDBannerView *banner = [[SDBannerView alloc] initWithFrame:CGRectMake(40, 64, self.view.bounds.size.width-80, 200)];
//    [banner setPageType:PageControlTypeDownRight];
//    [banner setCurrentPageIndicatorTintColor:[UIColor greenColor]];
//    [banner setPlaceholderImage:[UIImage imageNamed:@"downtown.jpg"]];
//    [banner setAutoScroll:NO];
//    banner.autoScrollTimeInterval = 10.0f;
//    banner.placeholderImage = [UIImage imageNamed:@"1.jpg"];
//    [banner setCurrentIndexDidTap:^(NSInteger index) {
//        NSLog(@"index = %ld",index);
//    }];
//    [self.view addSubview:banner];
//    [banner setImages:array];
    
    [array removeAllObjects];
    [array addObject:@"http://ww4.sinaimg.cn/large/0060lm7Tgy1fd9vesjrpsj30dw0kuacd.jpg"];
    [array addObject:@"http://ww4.sinaimg.cn/large/0060lm7Tgy1fd9vbzh431j30dw0j9mzm.jpg"];
    [array addObject:@"http://pic72.nipic.com/file/20150716/21422793_144600530000_2.jpg"];
    
//    [self.bottomBannerView setPageType:PageControlTypeUpleft];
//    [self.bottomBannerView setCurrentPageIndicatorTintColor:[UIColor yellowColor]];
    [self.bottomBannerView setPlaceholderImage:[UIImage imageNamed:@"downtown.jpg"]];
//    [self.bottomBannerView setAutoScroll:NO];
//    self.bottomBannerView.autoScrollTimeInterval = 1.0f;
    [self.bottomBannerView setCurrentIndexDidTap:^(NSInteger index) {
        NSLog(@"bottom index = %ld",index);
    }];
    [self.bottomBannerView setImages:array];
}
- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}


@end
