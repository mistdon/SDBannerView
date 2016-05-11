//
//  SDLeftSideViewController.m
//  SPC330
//
//  Created by shendong on 16/5/6.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "SDLeftSideViewController.h"
#import "SDTabBarView.h"
@interface SDLeftSideViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableiview;
@end

@implementation SDLeftSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableiview  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SD_SCREENWIDTH,SD_SCREENHEIGHT) style:UITableViewStylePlain];
    self.tableiview.delegate  = self;
    self.tableiview.dataSource = self;
    [self.view addSubview:self.tableiview];
    [self.tableiview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"hh"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hh"];
    cell.textLabel.text = [NSString stringWithFormat:@"index = %lu",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
