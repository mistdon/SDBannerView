//
//  PersonInfoArrayDataSource.m
//  SeperateTableView
//
//  Created by shendong on 16/4/25.
//  Copyright © 2016年 shendong.enterprise. All rights reserved.
//

#import "PersonInfoArrayDataSource.h"


@interface PersonInfoArrayDataSource ()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) tableviewCellConfigrueBlock configureBlock;

@end

@implementation PersonInfoArrayDataSource

- (instancetype)init{
    return  nil;
}
- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(tableviewCellConfigrueBlock)completeBlock{
    self = [super init];
    if (self) {
        _items          = items;
        _cellIdentifier = [cellIdentifier copy];
        _configureBlock = completeBlock;
    }
    return self;
}

- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.items[indexPath.section] objectAtIndex:indexPath.row];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.items.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureBlock(cell, item);
    return cell;
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return @[@"A",@"B",@"C",@"D"];
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"first class";
}

//and other tableview datasource method you want
@end
