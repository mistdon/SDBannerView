//
//  SDHomepageViewController.m
//  DouYu
//
//  Created by shendong on 16/5/11.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "SDHomepageViewController.h"
#import "SDHomepageTableViewCell.h"

static NSString *const cellIdentifier = @"cellIdentifier";

@interface SDHomepageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation SDHomepageViewController{
    NSArray *titles;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    titles = @[@"颜值",@"最热",@"DOTA2",@"主机游戏",@"穿越火线",@"英雄联盟",@"炉石传说",@"魔兽世界",@"守望先锋",@"王者荣耀",@"星际争霸",@"格斗游戏"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SDHomepageTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.tableView];
}
#pragma mark - UICollectionViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SDHomepageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary *dict = @{SDHomePageCellHeaderImage : @"" , SDHomePageCellHeaderTitle : titles[indexPath.row]};
    [cell configureSubViews:dict];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH + 44;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
