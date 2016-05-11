//
//  LeftViewController.m
//  SPC330
//
//  Created by shendong on 16/5/6.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"

  static NSString *const cellidentifier = @"cellidentiofer";
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    tableview.dataSource   = self;
    tableview.delegate     = self;
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellidentifier];
    [self.view addSubview:tableview];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
//    if (cell) {
//        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
//    }
    cell.textLabel.text = [NSString stringWithFormat:@"index = %lu",(long)indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hahh" object:nil];
    
//    (uivie)delegate.window.rootViewController
}
@end
