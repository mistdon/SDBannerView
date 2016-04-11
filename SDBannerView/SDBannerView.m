//
//  SDBannerView.m
//  SDBannerView
//
//  Created by shendong on 16/3/17.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "SDBannerView.h"
#import "SDHelper.h"
#import "SDBannerContentView.h"

@interface SDBannerView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray<UIImage *> *imagesources;
@property (nonatomic, strong) NSMutableArray *urlStringSources;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) SDBannerContentView *leftImageView, *middleImageView, *rightImageView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation SDBannerView{
    CGFloat _kWidth;
    CGFloat _KHeight;
    NSInteger _numbersOfImages;
    NSInteger _currentIndex;
}
#pragma mark - lifecycle
- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //todo
        _kWidth = frame.size.width;
        _KHeight = frame.size.height;
        [self configureDefaultValues];
    }
    return self;
}
#pragma mark - lazy loading
- (NSMutableArray *)urlStringSources {
    if (!_urlStringSources) {
        _urlStringSources = [NSMutableArray array];
    }
    return _urlStringSources;
}
- (NSMutableArray *)imagesources{
    if (!_imagesources) {
        _imagesources = [NSMutableArray array];
    }
    return _imagesources;
}
#pragma mark - Init with subviews
- (void)configureDefaultValues{
    UIImage *image        = [[UIImage alloc] init]
    _placeholderImage     = image;
    _autoBanner           = YES;
    _ScrollStyleAnimation = SDScrollStyleAnimationNone;
    _numbersOfImages      = 1;
    [self confirgueScrollView];
    [self confirgueImageView];
    [self confirguePageControl];    
    _leftImageView.image = _placeholderImage;
}
- (void)confirgueScrollView{
    if (!_scrollView) {
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _kWidth, _KHeight)];
        [self addSubview:scroll];
        _scrollView                                = scroll;
        _scrollView.pagingEnabled                  = YES;
        _scrollView.backgroundColor                = [UIColor redColor];
        _scrollView.delegate                       = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _currentIndex = 0;
    }
}
- (void)confirgueImageView{
    if (!_leftImageView) {
        SDBannerContentView *leftTemp     = [[SDBannerContentView alloc] initWithFrame:CGRectMake(0, 0, _kWidth, _KHeight)];
        SDBannerContentView *middleTemp   = [[SDBannerContentView alloc] initWithFrame:CGRectMake(_kWidth, 0, _kWidth, _KHeight)];
        SDBannerContentView *rightTemp    = [[SDBannerContentView alloc] initWithFrame:CGRectMake(_kWidth * 2, 0, _kWidth, _KHeight)];
        middleTemp.userInteractionEnabled = YES;
        [middleTemp addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
        [_scrollView addSubview:leftTemp];
        [_scrollView addSubview:middleTemp];
        [_scrollView addSubview:rightTemp];
        _leftImageView   = leftTemp;
        _middleImageView = middleTemp;
        _rightImageView  = rightTemp;
    }
}
- (void)confirguePageControl{
    if (!_pageControl) {
        UIPageControl *page                = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _KHeight - 20, _kWidth, 0)];
        page.pageIndicatorTintColor        = [UIColor whiteColor];
        page.currentPageIndicatorTintColor = [UIColor redColor];
        page.hidesForSinglePage            = YES;
        page.currentPage                   = 0;
        page.hidesForSinglePage            = YES;
        page.numberOfPages                 = _numbersOfImages;
        [self addSubview:page];
        _pageControl                    = page;
    }
}
#pragma mark -  配置属性
- (void)setNumbersOfImage:(NSInteger)numbersofimage{
    _autoScrollTimeInterval = 3.f;
    if (_numbersOfImages > 1) {
        [self setupTimer];
    }
    [self changeImageLeft:_numbersOfImages-1 middle:0 right:1];
}
- (void)setDatasource:(NSArray *)datasource{
    if (datasource.count == 0) return;
    _numbersOfImages = datasource.count;
    _pageControl.numberOfPages = _numbersOfImages;
    if (self.imagesources.count > 0){
        [self.imagesources removeAllObjects];
    };
    if (self.urlStringSources.count > 0) {
        [self.urlStringSources removeAllObjects];
    }
    if (_numbersOfImages > 0) {
        _scrollView.contentSize = _numbersOfImages==1?CGSizeMake(0, 0): CGSizeMake(_kWidth * 3, 0);
    }
    if ([[datasource firstObject] isKindOfClass:[UIImage class]]) {
        //local image
        [self setImageData:datasource local:YES];
    }else{ //remote image
        [self setImageData:datasource local:NO];
    }
    [self setNumbersOfImage:_numbersOfImages];
}
- (void)setPlaceholderImage:(UIImage *)placeholderImage{
    _placeholderImage = placeholderImage;
    _leftImageView.image = _placeholderImage;
}
- (void)setImageData:(NSArray *)names local:(BOOL)local{
    if (local) {
        [self.imagesources addObjectsFromArray:names];
        for (id object in names) {
            if (![object isKindOfClass:[UIImage class]]) {
                NSAssert([object isKindOfClass:[UIImage class]], @"Exception: bannerview datasource must be UIImage class");
            }
        }
    }else{
        [self.urlStringSources addObjectsFromArray:names];
        for (NSInteger index =0; index < names.count; index++) {
            [self.imagesources addObject:self.placeholderImage];
            [self loadImagesAtIndex:index];
        }
    }
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
- (void)setAutoBanner:(BOOL)autoBanner{
    if (autoBanner == YES) return;
    _autoBanner = NO;
    [self removeTimer];
}
- (void)changeImageLeft:(NSInteger)leftIndex middle:(NSInteger)middleIndex right:(NSInteger)rightIndex{
    if (_numbersOfImages == 1) {
        leftIndex = middleIndex = rightIndex = 0;
    }
    _leftImageView.image   = self.imagesources[leftIndex];
    _middleImageView.image = self.imagesources[middleIndex];
    _rightImageView.image  = self.imagesources[rightIndex];
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
- (void)setScrollStyleAnimation:(SDScrollStyleAnimation)ScrollStyleAnimation{
    _ScrollStyleAnimation = ScrollStyleAnimation;
}
#pragma mark UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self changeImageWithOffset:scrollView.contentOffset.x];
    if (self.ScrollStyleAnimation) {
        for (SDBannerContentView *subView in scrollView.subviews) {
            if ([subView respondsToSelector:@selector(imageOffsetValue:)] ) {
                if (self.ScrollStyleAnimation == SDScrollStyleAnimationNone ) {
                    [subView imageOffsetValue:0];
                }else if (self.ScrollStyleAnimation == SDScrollStyleAnimationScale) {
                    [subView imageOffsetValue:1];
                }else if(self.ScrollStyleAnimation == SDScrollStyleAnimationPagCurl) {
                    [subView imageOffsetValue:0.7];
                }
            }
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!_autoBanner)
    [self performSelector:@selector(fireTimer) withObject:nil afterDelay:0];
}
- (void)fireTimer{
    [_timer setFireDate:[NSDate date]];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [_timer setFireDate:[NSDate distantFuture]];
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
    if (_autoScrollTimeInterval < 0.5 || !_autoBanner || _numbersOfImages == 1)return;
    _timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    [_timer fire];
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
        [self.imagesources setObject:[UIImage imageWithData:data] atIndexedSubscript:index];
    }else{
        [NSURLConnection  sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if (!connectionError) {
                UIImage *image = [UIImage imageWithData:data];
                if (!image) return;
                [self.imagesources setObject:image atIndexedSubscript:index];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    if([SDHelper saveBannerCache:data WithIdentifier:url.absoluteString]){
                    };
                });
            }
        }];
    }
}
#pragma mark -Public
- (void)clearImageDataCache{
    [SDHelper clearBannerCache];
}
@end
