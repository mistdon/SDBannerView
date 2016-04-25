//
//  TableViewController.m
//  SeperateTableView
//
//  Created by shendong on 16/4/25.
//  Copyright © 2016年 shendong.enterprise. All rights reserved.
//

#import "TableViewController.h"
#import "Person+Personinfomation.h"
#import "Person.h"
#import "PersonInfoArrayDataSource.h"
#import "PersonCell.h"

static NSString *const tableviewCellIdentifier = @"identifier";

@interface TableViewController ()

@property (nonatomic, strong) NSArray<__kindof Person *> *data;
@property (nonatomic, strong) PersonInfoArrayDataSource *personInfoDataSource;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Persons";
    Person *p1 = [Person personWithName:@"one" age:19 birth:[NSDate date]];
    Person *p2 = [Person personWithName:@"two" age:20 birth:[NSDate date]];
    Person *p3 = [Person personWithName:@"three" age:21 birth:[NSDate date]];
    Person *p4 = [Person personWithName:@"four" age:22 birth:[NSDate date]];
    Person *p5 = [Person personWithName:@"five" age:23 birth:[NSDate date]];
    Person *p6 = [Person personWithName:@"six" age:24 birth:[NSDate date]];
    
    self.data = @[@[p1,p2],@[p3,p4,p5,p6]];
    
    [self setUpTableView];
}
- (void)setUpTableView{
    tableviewCellConfigrueBlock configureCellBlock = ^(PersonCell *cell, Person *person){
        [cell configureForPerson:[person personInfomation]];
    };
    self.personInfoDataSource = [[PersonInfoArrayDataSource alloc] initWithItems:self.data cellIdentifier:tableviewCellIdentifier configureCellBlock:configureCellBlock];
    self.tableView.dataSource = self.personInfoDataSource;
    [self.tableView registerNib:[PersonCell nib] forCellReuseIdentifier:tableviewCellIdentifier];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Person *person = (Person *)[self.personInfoDataSource itemAtIndexPath:indexPath];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:person.name message:[NSString stringWithFormat:@"age : %lu, birthday = %@",(unsigned long)person.age,person.birthday] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:NULL];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

@end
