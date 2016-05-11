//
//  TableViewController.m
//  SDAnimation
//
//  Created by shendong on 16/4/26.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "TableViewController.h"

static NSString *const cellIdentifier = @"identifier";
static NSString *const kclasstitle    = @"class_title";
static NSString *const kclassname     = @"class_name";

@interface TableViewController ()
@property (nonatomic, strong) NSArray *data;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"animaiton" ofType:@"plist"];
    self.data = [NSArray arrayWithContentsOfFile:path];
    //class_title   class_name
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self setnavgaitonTitleView];

}

- (void)setnavgaitonTitleView{
    UIView *titleview = [[UIView alloc] init];
    titleview.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = titleview;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor greenColor];
    [button setFrame:CGRectMake(0, 0, 100, 44)];
    button.center = titleview.center;
    NSLog(@"nav = %@",NSStringFromCGRect(self.navigationItem.titleView.frame));
    NSLog(@"titleview = %@",NSStringFromCGRect(titleview.frame));
    NSLog(@"button = %@",NSStringFromCGRect(button.frame));
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.data[indexPath.row] objectForKey:kclasstitle];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class class = NSClassFromString([self.data[indexPath.row] objectForKey:kclassname]);
    UIViewController *vc = [[class alloc] init];
    vc.title = [self.data [indexPath.row] objectForKey:kclasstitle];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
