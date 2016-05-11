//
//  SDTabBarView.m
//  SPC330
//
//  Created by shendong on 16/5/6.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "SDTabBarView.h"

//#define SD_SCREENWIDTH   [UIScreen mainScreen].bounds.size.width
//#define SD_SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

static CGFloat    const sd_tabBarViewHeight      = 49;
static NSUInteger const sd_tabBarButtonConstTag  = 1000;

#pragma mark - SDTabBarButtonItem -

static CGFloat const sd_ButtonItemRadio = 0.7;

@interface sdNormalButton: UIButton

@end

@implementation sdNormalButton

- (instancetype)init{
    if (self = [super init]) {
        self.imageView.contentMode    = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font          = [UIFont systemFontOfSize:11];
        self.showsTouchWhenHighlighted = YES;
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((contentRect.size.width * (1 - sd_ButtonItemRadio))/2, 0, contentRect.size.width * sd_ButtonItemRadio, contentRect.size.height * sd_ButtonItemRadio);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height * sd_ButtonItemRadio, contentRect.size.width, contentRect.size.height * (1 - sd_ButtonItemRadio));
}
@end

#pragma mark - sdCentralButton -

@interface sdCentralButton : UIButton

@end

@implementation sdCentralButton

- (instancetype)init{
    if (self = [super init]) {
        self.imageView.contentMode    = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font          = [UIFont systemFontOfSize:11];
        self.showsTouchWhenHighlighted = YES;
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((contentRect.size.width * (1 - 0.7))/2, 0, contentRect.size.width * 0.7, contentRect.size.height * 0.7);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height * 0.7, contentRect.size.width, contentRect.size.height * 0.3);
}


@end

@interface SDTabBarView ()

@property (nonatomic, strong) NSMutableArray *normalButtonArray;
@property (nonatomic, strong) NSMutableArray *selectedButtonArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSMutableArray *titlesArray;

@property (nonatomic, strong) UIView *seperateLine; //分割线
@property (nonatomic, strong) sdCentralButton *centralButton;
//@property (nonatomic, weak) sdTabBarBlock sdblock;

@end

@implementation SDTabBarView

- (sdCentralButton *)centralButton{
    if (!_centralButton) {
        _centralButton = [[sdCentralButton alloc] init];
        [self.centralButton addTarget:self action:@selector(tabBarViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.centralButton];
    }
    return _centralButton;
}
- (instancetype)init{
    return [self initWithFrame:CGRectMake(0, SD_SCREENHEIGHT - sd_tabBarViewHeight, SD_SCREENWIDTH, sd_tabBarViewHeight)];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _normalButtonArray   = [NSMutableArray array];
        _selectedButtonArray = [NSMutableArray array];
        _buttonArray         = [NSMutableArray array];
        _titlesArray         = [NSMutableArray array];
        _showCenteralItem    = NO;//default
        [self setUpDefaultUI];
    }
    return self;
}
- (void)setUpDefaultUI{
    self.seperateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    self.seperateLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.seperateLine];
}
- (void)setShowCenteralItem:(BOOL)showCenteralItem{
    _showCenteralItem = showCenteralItem;
}
- (void)setNormalTextColor:(UIColor *)normalTextColor{
    for (sdNormalButton *button in self.buttonArray) {
        [button setTitleColor:normalTextColor forState:UIControlStateNormal];
    }
    [self.centralButton setTitleColor:normalTextColor forState:UIControlStateNormal];
}
- (void)setSelectedTextColor:(UIColor *)selectedTextColor{
    for (sdNormalButton *button in self.buttonArray) {
        [button setTitleColor:selectedTextColor forState:UIControlStateSelected];
    }
    [self.centralButton setTitleColor:selectedTextColor forState:UIControlStateSelected];
}
- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex{
    _selectedItemIndex = selectedItemIndex;
    for (sdNormalButton *button in self.buttonArray) {
        button.selected = button.tag == selectedItemIndex - sd_tabBarButtonConstTag ? YES : NO;
    }
}
- (void)setItems:(NSArray<__kindof UIImage *> *)normal selected:(NSArray<__kindof UIImage *> *)selected title:(NSArray<__kindof NSString *> *)titles{
    if (normal.count != selected.count) {
        [NSException raise:@"SDTabBarViewException" format:@"SDTabBarView sources images and selectedImages cannot match each other"];
        return;
    }
    [self.normalButtonArray addObjectsFromArray:normal];
    [self.selectedButtonArray addObjectsFromArray:selected];
    [self.titlesArray addObjectsFromArray:titles];
    for (NSInteger index = 0 ; index < normal.count; index++) {
        sdNormalButton *button = [[sdNormalButton alloc] init];
        if (index == 0) {
            button.selected = YES;
        }
        [button setImage:normal[index] forState:UIControlStateNormal];
        [button setImage:selected[index] forState:UIControlStateSelected];
        [button setTitle:titles[index] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tabBarViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = index >= normal.count / 2 ? sd_tabBarButtonConstTag + index + 1: sd_tabBarButtonConstTag + index;
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
    NSUInteger buttonCount             = self.buttonArray.count % 2 == 0 ? self.buttonArray.count : self.buttonArray.count + 1;
    CGFloat centerButtonWidthAndHeight = 60;
    CGFloat normalButtonHeight         = 48;
    CGFloat normalButtonWidth          = self.frame.size.width / buttonCount;
    CGFloat centerButtonPotinX         = (self.frame.size.width - centerButtonWidthAndHeight) * 0.5;
    if (self.showCenteralItem) {
        self.centralButton.frame = CGRectMake(centerButtonPotinX, sd_tabBarViewHeight - centerButtonWidthAndHeight, centerButtonWidthAndHeight, centerButtonWidthAndHeight);
        self.centralButton.tag = (NSInteger)self.buttonArray.count / 2  + sd_tabBarButtonConstTag;
        normalButtonWidth = (self.frame.size.width - centerButtonWidthAndHeight - 20) / buttonCount;
    }
    CGFloat buttonX = 0;
    for (NSInteger index = 0; index < self.buttonArray.count; index++) {
        sdNormalButton *button = _buttonArray[index];
        if (self.showCenteralItem && button.tag - sd_tabBarButtonConstTag >= buttonCount / 2) {
            buttonX += centerButtonWidthAndHeight + 20;
        }
        button.frame = CGRectMake(buttonX, 0.5, normalButtonWidth, normalButtonHeight);
        buttonX += normalButtonWidth;
    }
}
- (void)tabBarViewButtonClicked:(sdNormalButton *)sender{
    for (sdNormalButton *button in self.buttonArray) {
        button.selected = NO;
    }
    self.centralButton.selected = NO;
    sender.selected             = YES;
    if (self.delegate  && [self.delegate respondsToSelector:@selector(sd_buttonItemClicked:)]) {
        [self.delegate sd_buttonItemClicked:(sender.tag - sd_tabBarButtonConstTag)];
    }
}
- (void)setCenteralItem:(UIImage *)image title:(NSString *)title{
    if (!self.showCenteralItem) return;
    [self.centralButton setImage:image forState:UIControlStateNormal];
    [self.centralButton setImage:image forState:UIControlStateSelected];
    [self.centralButton setTitle:title forState:UIControlStateNormal];
}
@end

