//
//  PersonCell.m
//  SeperateTableView
//
//  Created by shendong on 16/4/25.
//  Copyright © 2016年 shendong.enterprise. All rights reserved.
//

#import "PersonCell.h"
@interface PersonCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *ageLable;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLable;

@end
@implementation PersonCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (UINib *)nib{
    return [UINib nibWithNibName:@"PersonCell" bundle:nil];
}
- (void)configureForPerson:(NSDictionary *)personinfo{
    self.nameLable.text     = [NSString stringWithFormat:@"name: %@",personinfo[@"name"]];
    self.ageLable.text      = [NSString stringWithFormat:@"age: %@",personinfo[@"age"]];
    self.birthdayLable.text = [NSString stringWithFormat:@"birthday: %@",personinfo[@"birthday"]];
}
@end
