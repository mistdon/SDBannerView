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
}
@property (nonatomic, strong) NSMutableArray *datasources;
@property (nonatomic, strong) NSMutableArray *imageNamesArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *leftImageView, *middleImageView, *rightImageView;
@property (nonatomic, assign) NSUInteger currentIndex;
@end
static NSTimeInterval const KTimeInterval = 5.0f;
@implementation SDBannerView{
    NSInteger _numbersOfImages;
    NSTimer *_timer;
}
- (NSMutableArray *)datasources{
    if (_datasources == nil) {
        _datasources = [NSMutableArray array];
    }
    return _datasources;
}
- (NSMutableArray *)imageNamesArray{
    if (_imageNamesArray == nil) {
        _imageNamesArray = [NSMutableArray array];
    }
    return _imageNamesArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureDefaultValue];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self configureDefaultValue];
    }
    return self;
}
//after loaded on the xib or storyboard, should reset size parameters to get the exact size.
- (void)layoutSubviews{
    [super layoutSubviews];
    kWidth               = self.bounds.size.width;
    KHeight              = self.bounds.size.height;
    [self confirgueScrollView];
    [self confirgueImageView];
    [self confirguePageControl];
    [self setNumbersOfImage:self.imageNamesArray.count];
    
}
- (void)configureDefaultValue{
    _currentIndex        = 0;
    _autoScroll          = YES;
    _showPage            = YES;
    _pageType            = PageControlTypeDownCenter;
    _autoScrollTimeInterval = KTimeInterval;
    _placeholderImage    = [self bundlePlaceHolderImage];
    self.backgroundColor = [UIColor clearColor];
}
- (void)confirgueScrollView{
    CGFloat width = self.imageNamesArray.count > 1 ? kWidth * 3 : kWidth;
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scroll];
    _scrollView                                = scroll;
    _scrollView.contentSize                    = CGSizeMake(width, KHeight);
    _scrollView.pagingEnabled                  = YES;
    _scrollView.delegate                       = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.bounces                        = NO;
    _scrollView.backgroundColor                = [UIColor clearColor];
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
    if (!_showPage) return;
    UIPageControl *page                = [[UIPageControl alloc] init];
    _pageControl = page;
    [self addSubview:page];
    page.pageIndicatorTintColor        = self.pageIndicatorTintColor ?: [UIColor lightGrayColor];
    page.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor ?: [UIColor redColor];
    page.hidesForSinglePage            = YES;
    page.numberOfPages                 = self.imageNamesArray.count;
    page.currentPage                   = 0;
    [self setPageType:self.pageType];
}
#pragma mark -  settup confirguration
- (void)setNumbersOfImage:(NSInteger)numbersofimage{
    _numbersOfImages = numbersofimage;
    if (_numbersOfImages > 1) {
        [self setupTimer];
    }
    [self changeImageLeft:_numbersOfImages-1 middle:0 right:1];
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
}
- (void)setShowPage:(BOOL)showPage{
    _showPage = showPage;
}
- (void)setAutoScrollTimeInterval:(NSTimeInterval)autoScrollTimeInterval{
    _autoScrollTimeInterval = autoScrollTimeInterval;
}
- (void)setPlaceholderImage:(UIImage *)placeholderImage{
    _placeholderImage = placeholderImage;
}
- (void)setPageType:(PageControlType)pageType {
    _pageType = pageType;
    switch (pageType) {
        case PageControlTypeUpleft:
            [self.pageControl setFrame:CGRectMake(0, 20, _numbersOfImages * 20, 7)];
            break;
        case PageControlTypeUpCenter:
            [self.pageControl setFrame:CGRectMake(0, 20, kWidth, 7)];
            break;
        case PageControlTypeUpRight:
            [self.pageControl setFrame:CGRectMake(kWidth - _numbersOfImages * 20, 20, _numbersOfImages * 20, 7)];
            break;
        case PageControlTypeDownLeft:
            [self.pageControl setFrame:CGRectMake(0, KHeight-20, _numbersOfImages * 20, 7)];
            break;
        case PageControlTypeDownCenter:
            [self.pageControl setFrame:CGRectMake(0, KHeight-20, kWidth, 7)];
            break;
        case PageControlTypeDownRight:
            [self.pageControl setFrame:CGRectMake(kWidth - _numbersOfImages * 20, KHeight-20, _numbersOfImages * 20, 7)];
            break;
        default:
            break;
    }
}
#pragma mark - private method
- (void)changeImageLeft:(NSInteger)leftIndex middle:(NSInteger)middleIndex right:(NSInteger)rightIndex{
    if (_numbersOfImages == 1) {
        leftIndex = middleIndex = rightIndex = 0;
    }
    if (leftIndex < 0) {
        leftIndex = self.datasources.count - 1;
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
#pragma mark UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.datasources.count == 0) return;
    [self changeImageWithOffset:scrollView.contentOffset.x];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setupTimer];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}
#pragma mark - timer
- (void)setupTimer {
    if (!_autoScroll) return;
    if (_autoScrollTimeInterval < 0.5) _autoScrollTimeInterval = KTimeInterval;
    _timer = [NSTimer timerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(autoScrollToNext) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}
- (void)removeTimer{
    if (!_timer)return;
    [_timer invalidate];
    _timer = nil;
}
- (void)autoScrollToNext{
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + kWidth, 0) animated:YES];
}
- (void)removeFromSuperview {
    [super removeFromSuperview];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)requestImages:(NSArray *)imgs{
    [self.datasources removeAllObjects];
    for (int index = 0; index < imgs.count; index++) {
        NSString *imgnames = imgs[index];
        if ([self isUurlString:imgnames]) {
            if ([self cacheDataForUrl:[NSURL URLWithString:imgnames]]) {
                NSData *cacheData = [self cacheDataForUrl:[NSURL URLWithString:imgnames]];
                self.datasources[index] = [UIImage imageWithData:cacheData];
            }else{
                self.datasources[index] = self.placeholderImage ?: [self bundlePlaceHolderImage];
                __weak typeof(self)weakSelf = self;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     [weakSelf downloadImage:imgnames index:index];;
                });
            }
        }else{
            self.datasources[index] = [UIImage imageNamed:imgnames];
        }
    }
}
- (void)downloadImage:(NSString *)url index:(int)index{
    NSParameterAssert(url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    __weak typeof(self)weakself = self;
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakself)strongSelf = weakself;
        if (!error && data) {
            if (response) {// avoid for null response(nuallable)
                NSCachedURLResponse *respon = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
                [strongSelf cacheForUrl:respon requestUrl:[NSURL URLWithString:url]];
            }
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.datasources[index] = image;
            });
        }
    }];
    [task resume];
}
- (UIImage *)bundlePlaceHolderImage{
    NSBundle *bundle = [NSBundle bundleForClass:[SDBannerView class]];
    NSURL *url = [bundle URLForResource:@"SDBannerView" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    return [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"SDBanner_placeholder" ofType:@"png"]];
}
#pragma mark - URL cache
- (void)cacheForUrl:(NSCachedURLResponse *)urlResponse requestUrl:(NSURL *)url{
    [[NSURLCache sharedURLCache] storeCachedResponse:urlResponse forRequest:[NSURLRequest requestWithURL:url]];
}
- (nullable NSData *)cacheDataForUrl:(NSURL *)url{
    NSData *data = nil;
    NSCachedURLResponse *response = [[NSURLCache sharedURLCache] cachedResponseForRequest:[NSURLRequest requestWithURL:url]];
    if (response && response.data) {
        data = response.data;
    }
    return data;
}
- (BOOL)isUurlString:(NSString *)str{
    return [str hasPrefix:@"http"];
}
#pragma mark - public methods
- (void)setImages:(NSArray<__kindof NSString *> *)images{
    [self.imageNamesArray removeAllObjects];
    [self.imageNamesArray addObjectsFromArray:images];
    [self requestImages:images];
    _numbersOfImages = images.count;
}
@end
