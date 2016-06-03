//
//  SDBannerView.m
//  SDBannerView
//
//  Created by shendong on 16/3/17.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "SDBannerView.h"
@interface SDBannerView()<UIScrollViewDelegate>{
    CGFloat kWidth;
    CGFloat KHeight;
    __weak UIScrollView *_scrollView;
    __weak UIImageView *_leftImageView, *_middleImageView, *_rightImageView;
    __weak UIPageControl *_pageControl;
}
@property (nonatomic, copy) NSArray *datasources;
@end

@implementation SDBannerView{
    NSInteger _numbersOfImages;
    NSInteger _currentIndex;
    NSTimer *_timer;
}
- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray<UIImage *> *)names {
    NSAssert(names.count!=0, @"Exception: BannerView init method: iamgenames cannot be nil");
    self = [super initWithFrame:frame];
    if (self) {
        kWidth = frame.size.width;
        KHeight = frame.size.height;
        _numbersOfImages = names.count;
        [self confirgueScrollView];
        [self setImageData:names];
        [self setNumbersOfImage:names.count];
    }
    return self;
}
- (void)confirgueScrollView{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scroll];
    
    _scrollView                                = scroll;
    _scrollView.pagingEnabled                  = YES;
    _scrollView.backgroundColor                = [UIColor lightGrayColor];
    _scrollView.delegate                       = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.contentSize                    = _numbersOfImages==1?CGSizeMake(0, 0): CGSizeMake(kWidth * 3, 0);
    
    _currentIndex = 0;
}
- (void)confirgueImageView{
    UIImageView *leftTemp   = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, KHeight)];
    UIImageView *middleTemp = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, KHeight)];
    UIImageView *rightTemp  = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * 2, 0, kWidth, KHeight)];
    middleTemp.userInteractionEnabled = YES;
    
    [middleTemp addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    
    [_scrollView addSubview:leftTemp];
    [_scrollView addSubview:middleTemp];
    [_scrollView addSubview:rightTemp];
    _leftImageView   = leftTemp;
    _middleImageView = middleTemp;
    _rightImageView  = rightTemp;
    
}
- (void)confirguePageControl{
    UIPageControl *page                = [[UIPageControl alloc] initWithFrame:CGRectMake(0,KHeight - 20,kWidth, 7)];
    page.pageIndicatorTintColor        = [UIColor lightGrayColor];
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.hidesForSinglePage            = YES;
    page.numberOfPages                 = _numbersOfImages;
    page.currentPage                   = 0;
    
    [self addSubview:page];
    _pageControl = page;
}
#pragma mark -  配置属性
- (void)setNumbersOfImage:(NSInteger)numbersofimage{
    [self confirgueImageView];
    [self confirguePageControl];
    _autoScrollTimeInterval = 3.f;
    if (_numbersOfImages > 1) {
        [self setupTimer];
    }
    [self changeImageLeft:_numbersOfImages-1 middle:0 right:1];
}
- (void)setImageData:(NSArray<UIImage *>*)names{
    for (id object in names) {
        if (![object isKindOfClass:[UIImage class]]) {
            NSAssert([object isKindOfClass:[UIImage class]], @"Exception: bannerview datasource must be UIImage class");
        }
    }
    _datasources = [names copy];
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
- (void)changeImageLeft:(NSInteger)leftIndex middle:(NSInteger)middleIndex right:(NSInteger)rightIndex{
    if (_numbersOfImages == 1) {
        leftIndex = middleIndex = rightIndex = 0;
    }
    _leftImageView.image   = _datasources[leftIndex];
    _middleImageView.image = _datasources[middleIndex];
    _rightImageView.image  = _datasources[rightIndex];
    [_scrollView setContentOffset:CGPointMake(kWidth, 0)];
}
- (void)imageViewDidTap{
    if (self.currentIndexDidTap) {
        self.currentIndexDidTap(_currentIndex);
    }
}
- (void)setAutoScrollTimeInterval:(NSTimeInterval)autoScrollTimeInterval{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self removeTimer];
    [self setupTimer];
}
- (void)setPageType:(PageControlType)pageType {
    switch (pageType) {
        case PageControlTypeUpleft:
            [_pageControl setFrame:CGRectMake(0, 20, _numbersOfImages * 20, 7)];
            break;
        case PageControlTypeUpCenter:
            [_pageControl setFrame:CGRectMake(0, 20, kWidth, 7)];
            break;
        case PageControlTypeUpRight:
            [_pageControl setFrame:CGRectMake(kWidth - _numbersOfImages * 20, 20, _numbersOfImages * 20, 7)];
            break;
        case PageControlTypeDownLeft:
            [_pageControl setFrame:CGRectMake(0, KHeight-20, _numbersOfImages * 20, 7)];
            break;
        case PageControlTypeDownCenter:
            [_pageControl setFrame:CGRectMake(0, KHeight-20, kWidth, 7)];
            break;
        case PageControlTypeDownRight:
            [_pageControl setFrame:CGRectMake(kWidth - _numbersOfImages * 20, KHeight-20, _numbersOfImages * 20, 7)];
            break;
        default:
            break;
    }
}
#pragma mark UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self changeImageWithOffset:scrollView.contentOffset.x];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setupTimer];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}
- (void)changeImageWithOffset:(CGFloat)offsetX {
    if (offsetX >= kWidth * 2) {
        _currentIndex ++;
        if (_currentIndex == _numbersOfImages - 1) {
            [self changeImageLeft:_currentIndex-1 middle:_currentIndex right:0];
        }else if (_currentIndex == _numbersOfImages){
            _currentIndex = 0;
            [self changeImageLeft:_numbersOfImages-1 middle:0 right:1];
        }else{
            [self changeImageLeft:_currentIndex-1 middle:_currentIndex right:_currentIndex+1];
        }
    }
    if (offsetX <= 0) {
        _currentIndex--;
        if (_currentIndex == 0) {
            [self changeImageLeft:_numbersOfImages-1 middle:0 right:1];
        }else if(_currentIndex == -1){
            _currentIndex = _numbersOfImages - 1;
            [self changeImageLeft:_currentIndex-1 middle:_currentIndex right:0];
        }else{
            [self changeImageLeft:_currentIndex-1 middle:_currentIndex right:_currentIndex+1];
        }
    }
    _pageControl.currentPage = _currentIndex;
}
#pragma mark -定时器
- (void)setupTimer {
    if (_autoScrollTimeInterval < 0.5)return;
    _timer = [NSTimer timerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}
- (void)removeTimer{
    if (!_timer)return;
    [_timer invalidate];
    _timer = nil;
}
- (void)autoScroll{
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x+kWidth, 0) animated:YES];
}
- (void)removeFromSuperview {
    [super removeFromSuperview];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
@end
