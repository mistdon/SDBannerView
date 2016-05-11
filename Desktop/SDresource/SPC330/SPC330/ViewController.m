//
//  ViewController.m
//  SPC330
//
//  Created by shendong on 16/5/5.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "ViewController.h"
#import "SDBUTTON.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor orangeColor];
//    UITableView *table = [[UITableView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:table];
    SDBUTTON *button = [[SDBUTTON alloc] init];
    button.frame = CGRectMake(100, 100, 200, 49);
    button.backgroundColor = [UIColor redColor];
    [button setImage:[UIImage imageNamed:@"tab_me_press"] forState:UIControlStateNormal];
    [button setTitle:@"首页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hhhhhh) forControlEvents:UIControlEventTouchUpInside];
//    [button setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:2];
    [self.view addSubview:button];
    NSLog(@"%s",__FUNCTION__);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hhhhhh) name:@"1111" object:nil];

}
- (void)buttonClicked{
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}
- (void)hhhhhh{
    UIViewController *vew = [UIViewController new];
    vew.hidesBottomBarWhenPushed = YES;
//    vew.
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
