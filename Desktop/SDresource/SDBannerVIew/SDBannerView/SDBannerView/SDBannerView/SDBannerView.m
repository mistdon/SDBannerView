//
//  SDBannerView.m
//  SDBannerView
//
//  Created by shendong on 16/3/17.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "SDBannerView.h"
#import "SDHelper.h"

@interface SDBannerView()<UIScrollViewDelegate>{
    CGFloat _kWidth;
    CGFloat _KHeight;
    NSInteger _ImageSourcesType;  //图片源类型:当为本地图片时=100,网络加载图片时为101;
    __weak UIScrollView *_scrollView;
    __weak UIImageView *_leftImageView, *_middleImageView, *_rightImageView;
    __weak UIPageControl *_pageControl;
}
@property (nonatomic, copy) NSMutableArray *datasources;
@property (nonatomic, strong) NSMutableArray *urlStringSources;
@end

@implementation SDBannerView{
    NSInteger _numbersOfImages;
    NSInteger _currentIndex;
    NSTimer *_timer;
}
- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray<UIImage *> *)names {
    self = [super initWithFrame:frame];
    NSAssert(names.count!=0, @"Exception: BannerView init method: sources cannot be nil");
    if (self) {
        [self setupDefaultValues:names.count];
        _ImageSourcesType = 100;
        [self confirgueScrollView];
        [self setImageData:names];
        [self setNumbersOfImage:names.count];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame urls:(NSArray<NSString *> *)imageUrls{
    self = [super initWithFrame:frame];
    NSAssert(imageUrls.count!=0, @"Exception: BannerView init method: sources cannot be nil");
    if (self) {
        [self setupDefaultValues:imageUrls.count];
        _ImageSourcesType = 101;
        [self.urlStringSources addObjectsFromArray:imageUrls];
        [self confirgueScrollView];
        [self setImageData:nil];
        [self setNumbersOfImage:imageUrls.count];
    }
    return self;
}
- (NSMutableArray *)urlStringSources {
    if (!_urlStringSources) {
        _urlStringSources = [NSMutableArray array];
    }
    return _urlStringSources;
}
#pragma mark - Init with subviews
- (void)setupDefaultValues:(NSInteger )count{
    _kWidth           = self.frame.size.width;
    _KHeight          = self.frame.size.height;
    _numbersOfImages  = count;
    _autoBanner       = YES;
    _placeholderImage = [UIImage imageNamed:@"1.jpg"];
    _datasources      = [NSMutableArray arrayWithCapacity:count];
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
    _scrollView.contentSize                    = _numbersOfImages==1?CGSizeMake(0, 0): CGSizeMake(_kWidth * 3, 0);
    
    _currentIndex = 0;
}
- (void)confirgueImageView{
    UIImageView *leftTemp   = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _kWidth, _KHeight)];
    UIImageView *middleTemp = [[UIImageView alloc] initWithFrame:CGRectMake(_kWidth, 0, _kWidth, _KHeight)];
    UIImageView *rightTemp  = [[UIImageView alloc] initWithFrame:CGRectMake(_kWidth * 2, 0, _kWidth, _KHeight)];
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
    UIPageControl *page                = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_KHeight - 20,_kWidth, 7)];
    page.pageIndicatorTintColor        = [UIColor whiteColor];
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
    if (_ImageSourcesType == 101) { //网络加载图片
        for (NSInteger index =0; index < _numbersOfImages; index++) {
            [_datasources addObject:_placeholderImage];
            [self loadImagesAtIndex:index];
        }
    }
    for (id object in names) {
        if (![object isKindOfClass:[UIImage class]]) {
            NSAssert([object isKindOfClass:[UIImage class]], @"Exception: bannerview datasource must be UIImage class");
        }
    }
    if (_ImageSourcesType == 100) {
        _datasources = [names copy];
    }
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
- (void)setAutoBanner:(BOOL)autoBanner{
    if (autoBanner == NO) {
        _autoBanner = NO;
        [self removeTimer];
    }
}
- (void)changeImageLeft:(NSInteger)leftIndex middle:(NSInteger)middleIndex right:(NSInteger)rightIndex{
    if (_numbersOfImages == 1) {
        leftIndex = middleIndex = rightIndex = 0;
    }
    _leftImageView.image   = _datasources[leftIndex];
    _middleImageView.image = _datasources[middleIndex];
    _rightImageView.image  = _datasources[rightIndex];
    [_scrollView setContentOffset:CGPointMake(_kWidth, 0)];
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
- (void)setPageType:(PageControlPosition)pageType {
    switch (pageType) {
        case PageControlPositionUpleft:
            [_pageControl setFrame:CGRectMake(0, 20, _numbersOfImages * 20, 7)];
            break;
        case PageControlPositionUpCenter:
            [_pageControl setFrame:CGRectMake(0, 20, _kWidth, 7)];
            break;
        case PageControlPositionUpRight:
            [_pageControl setFrame:CGRectMake(_kWidth - _numbersOfImages * 20, 20, _numbersOfImages * 20, 7)];
            break;
        case PageControlPositionDownLeft:
            [_pageControl setFrame:CGRectMake(0, _KHeight-20, _numbersOfImages * 20, 7)];
            break;
        case PageControlPositionDownCenter:
            [_pageControl setFrame:CGRectMake(0, _KHeight-20, _kWidth, 7)];
            break;
        case PageControlPositionDownRight:
            [_pageControl setFrame:CGRectMake(_kWidth - _numbersOfImages * 20, _KHeight-20, _numbersOfImages * 20, 7)];
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
    if (_autoBanner) {
        [self setupTimer];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}
- (void)changeImageWithOffset:(CGFloat)offsetX {
    if (offsetX >= _kWidth * 2) {
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
    if (_autoScrollTimeInterval < 0.5 || !_autoBanner)return;
    _timer = [NSTimer timerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}
- (void)removeTimer{
    if (!_timer)return;
    [_timer invalidate];
    _timer = nil;
}
- (void)autoScroll{
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + _kWidth, 0) animated:YES];
}
- (void)removeFromSuperview {
    [super removeFromSuperview];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
#pragma mark - downLoad and cache images
- (void)loadImagesAtIndex:(NSInteger)index {
    NSString *urlString = self.urlStringSources[index];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [SDHelper getBannerCacheDataWithIdentifier:urlString];
    if (data) {
        [self.datasources setObject:[UIImage imageWithData:data] atIndexedSubscript:index];
    }else{
        [NSURLConnection  sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if (!connectionError) {
                UIImage *image = [UIImage imageWithData:data];
                if (!image) {
                    NSLog(@"无法获取图片,index = %lu",index);
                    return ;
                }
                [self.datasources setObject:image atIndexedSubscript:index];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    if([SDHelper saveBannerCache:data WithIdentifier:url.absoluteString]){
                    };
                });
            }
        }];
    }
}
- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}
@end
