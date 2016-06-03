//
//  ViewController.m
//  SDBannerView
//
//  Created by shendong on 16/3/17.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "ViewController.h"
#import "SDBannerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 3; i++) {
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]]];
    };
    SDBannerView *banner = [[SDBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250) imageNames:array];
    [banner setPageType:PageControlTypeDownRight];
    [banner setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [banner setCurrentIndexDidTap:^(NSInteger index) {
        NSLog(@"index = %ld",index);
    }];
    [self.view addSubview:banner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
