//
//  SDSideDrawerViewController.m
//  SPC330
//
//  Created by shendong on 16/5/10.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "SDSideDrawerViewController.h"
#import <UIViewController+MMDrawerController.h>

@interface SDSideDrawerViewController ()

@end

@implementation SDSideDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hhhhhh) name:@"hahh" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)hhhhhh{
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    [delegate.menu setContentViewController:delegate.menu.contentViewController animated:YES];
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
//    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    
    CGFloat proportion = 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.mm_drawerController.centerViewController.view.center = CGPointMake(self.view.center.x + 0, self.view.center.y);
        self.mm_drawerController.centerViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"1111" object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
