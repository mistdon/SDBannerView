//
//  JPTableViewController.m
//  SDMapHome
//
//  Created by shendong on 16/4/6.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "JPTableViewController.h"
#import "JPViewController.h"


static NSString *const jpcell = @"jpcellIdentifier";

@interface JPTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *exchangeButtonItem;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation JPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray arrayWithObjects:@"123",@"234",nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:jpcell];
    
    self.exchangeButtonItem.title = [[NSUserDefaults standardUserDefaults] objectForKey:@"JSPatch"] ? @"JSPatch" : @"NO JSPath";
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exchangeAction:(UIBarButtonItem *)sender {
    NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
    if ([stand objectForKey:@"JSPatch"]){
        [stand removeObjectForKey:@"JSPatch"];
        [self.exchangeButtonItem setTitle:@"NO JSPath"];
    }else{
        [self.exchangeButtonItem setTitle:@"JSPatch"];
        [stand setObject:@"Load" forKey:@"JSPatch"];
    }
    [stand synchronize];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath.row = %ld",(long)indexPath.row);
    NSInteger row = indexPath.row;
//    if (self.dataSource.count > row) {
        NSString *content = self.dataSource[row];  //可能会超出数组范围导致crash
        JPViewController *ctrl = [[JPViewController alloc] initWithContent:content];
        [self.navigationController pushViewController:ctrl animated:YES];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:jpcell ];
    cell.textLabel.text   = [NSString stringWithFormat:@"index = %d",(int)indexPath.row];
    return cell;
}

@end
