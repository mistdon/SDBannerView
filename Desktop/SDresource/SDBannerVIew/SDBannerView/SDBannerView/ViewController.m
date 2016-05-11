//
//  ViewController.m
//  SDBannerView
//
//  Created by shendong on 16/3/17.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "ViewController.h"
#import "SDBannerView.h"
#import "SDHelper.h"
@interface ViewController ()

@end

@implementation ViewController{
//    SDBannerView *banner;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     [SDHelper clearBannerCache];
    NSLog(@"path = %@",NSHomeDirectory());
    
    [self localImageLoaded];
//    [self remoteImageLoaded];
    

}
- (IBAction)clearCache:(UIBarButtonItem *)sender {
    [SDHelper clearBannerCache];
}
/**
 *  本地加载图片
 */
- (void)localImageLoaded {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 1; i < 8; i++) {
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]]];
    };
//    SDBannerView *localBanner = [[SDBannerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-250, self.view.bounds.size.width, 250) imageNames:array];
    SDBannerView *localBanner = [[SDBannerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-250-44, self.view.bounds.size.width, 250)];
    localBanner.dataSource = array;
    [localBanner setPageType:PageControlPositionDownRight];
    [localBanner setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [localBanner setCurrentIndexDidTap:^(NSInteger index) {
        NSLog(@"index = %ld",index);
    }];
//    [localBanner setAutoBanner:NO];
    [self.view addSubview:localBanner];
}
/**
 *  网络获取图片
 */
- (void)remoteImageLoaded{
    NSString *urlStr1 = @"http://img10.3lian.com/sc6/show02/67/27/02.jpg";
    NSString *urlStr2 = @"http://img161.poco.cn/mypoco/myphoto/20100424/19/53310080201004241856521800459127582_005.jpg";
    NSString *urlStr3 = @"http://img4.duitang.com/uploads/item/201408/30/20140830185433_FnJLA.jpeg";
    NSString *urlStr4 = @"http://tupian.enterdesk.com/2013/xll/012/26/3/1.jpg";
    NSArray *arr = @[urlStr1,urlStr2,urlStr3,urlStr4];
    SDBannerView *banner = [[SDBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
    banner.dataSource = banner;
    [banner setPageType:PageControlPositionDownCenter];
    [banner setCurrentIndexDidTap:^(NSInteger index) {
        NSLog(@"index = %ld",index);
    }];
    [self.view addSubview:banner];;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
