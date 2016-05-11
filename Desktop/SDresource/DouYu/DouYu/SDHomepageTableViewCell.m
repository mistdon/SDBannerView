//
//  SDHomepageTableViewCell.m
//  DouYu
//
//  Created by shendong on 16/5/11.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "SDHomepageTableViewCell.h"
#import "SDHomepageContentCollectionViewCell.h"

static NSString *const collectionViewCellIdentifier = @"collectionViewCellIdentifier";



@interface SDHomepageTableViewCell()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *headerLeftButton;
@property (weak, nonatomic) IBOutlet UICollectionView *colletionView;
@property (nonatomic, copy) NSMutableDictionary *infos;

@end
@implementation SDHomepageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UICollectionViewFlowLayout *layout      = [[UICollectionViewFlowLayout alloc] init];
    self.colletionView.collectionViewLayout = layout;
    self.colletionView.dataSource           = self;
    self.colletionView.delegate             = self;
    self.colletionView.scrollEnabled        = NO;
    [self.colletionView registerNib:[UINib nibWithNibName:@"SDHomepageContentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionViewCellIdentifier];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark flowlayout
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SDHomepageContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(SDHomePageCellEdgeSet, SDHomePageCellEdgeSet, SDHomePageCellEdgeSet, SDHomePageCellEdgeSet);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - SDHomePageCellEdgeSet * 3)/2, (SCREEN_WIDTH - SDHomePageCellEdgeSet * 3)/2);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了 %@,indexpath = %lu",self.infos[SDHomePageCellHeaderTitle],indexPath.row);
}
- (void)configureSubViews:(NSDictionary *)dictionary{
    self.infos = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [self.headerLeftButton.imageView setImage:[UIImage imageNamed:@"icon_honor1"]];
    [self.headerLeftButton setTitle:dictionary[SDHomePageCellHeaderTitle] ? dictionary[SDHomePageCellHeaderTitle] : nil forState:UIControlStateNormal];
}
@end
