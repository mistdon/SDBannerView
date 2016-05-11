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
    BOOL _remoteImageType;  //图片源类型:当为本地图片时=100,网络加载图片时为101;
    UIImageView *_leftImageView, *_middleImageView, *_rightImageView;
    UIPageControl *_pageControl;
}
@property (nonatomic, strong) UIScrollView   *scrollView;
@property (nonatomic, copy  ) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *urlStringSources;
@end

@implementation SDBannerView{
    NSInteger _numbersOfImages;
    NSInteger _currentIndex;
    NSTimer *_timer;
    NSMutableArray *_dataSource;
}
#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        //todo
        NSLog(@"frame");
        _kWidth                 = frame.size.width;
        _KHeight                = frame.size.height;
        _autoBanner             = YES;
        _remoteImageType        = NO;
        _scrollView             = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _kWidth, _KHeight)];
        _scrollView.contentSize = CGSizeMake(_kWidth, 0);
        [self addSubview:_scrollView];
        [self confirgueScrollView];
    }
    return self;
}
- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}
//- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray<UIImage *> *)names {
//    self = [super initWithFrame:frame];
//    NSAssert(names.count!=0, @"Exception: BannerView init method: sources cannot be nil");
//    if (self) {
//        
//        _remoteImageType = NO;
//        [self confirgueScrollView];
//        [self setImageData:names];
//        [self setNumbersOfImage:names.count];
//        
//    }
//    return self;
//}
//- (instancetype)initWithFrame:(CGRect)frame urls:(NSArray<NSString *> *)imageUrls{
//    self = [super initWithFrame:frame];
//    NSAssert(imageUrls.count!=0, @"Exception: BannerView init method: sources cannot be nil");
//    if (self) {
////        [self setupDefaultValues:imageUrls.count];
//        _remoteImageType = YES;
//        [self.urlStringSources addObjectsFromArray:imageUrls];
//        [self confirgueScrollView];
//        [self setImageData:nil];
//        [self setNumbersOfImage:imageUrls.count];
//    }
//    return self;
//}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //todo
        NSLog(@"decoder");
        NSLog(@"%s",__FUNCTION__);
    }
    return self;
}
#pragma mark - lazyloading
- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (NSMutableArray *)urlStringSources {
    if (!_urlStringSources) {
        _urlStringSources = [NSMutableArray array];
    }
    return _urlStringSources;
}
#pragma mark - Init with subviews
- (void)configureDefaultValues{
//    _kWidth           = self.frame.size.width;
//    _KHeight          = self.frame.size.height;
//    _numbersOfImages  = count;
    
//    _placeholderImage = [UIImage imageNamed:@"1.jpg"];
//    _imageArray      = [NSMutableArray arrayWithCapacity:count];
//    _imageArray  = [[NSMutableArray alloc] init];
}
//- (void)setupDefaultValues:(NSInteger )count{
//    _kWidth           = self.frame.size.width;
//    _KHeight          = self.frame.size.height;
//    _numbersOfImages  = count;
//    _autoBanner       = YES;
//    _placeholderImage = [UIImage imageNamed:@"1.jpg"];
//    _imageArray      = [NSMutableArray arrayWithCapacity:count];
//}
- (void)confirgueScrollView{
//    _scrollView                                = scroll;
    _scrollView.bounces                        = NO;
    _scrollView.pagingEnabled                  = YES;
    _scrollView.backgroundColor                = [UIColor redColor];
    _scrollView.delegate                       = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _currentIndex                              = 0;
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
//- (void)setFrame:(CGRect)frame{
//    _kWidth  = frame.size.width;
//    _KHeight = frame.size.height;
//    [_scrollView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
//}
- (void)setImageData:(NSArray<UIImage *>*)names{
    if (_remoteImageType == YES) { //网络加载图片
        for (NSInteger index =0; index < _numbersOfImages; index++) {
            [_imageArray addObject:_placeholderImage];
            [self loadImagesAtIndex:index];
        }
    }
    for (id object in names) {
        if (![object isKindOfClass:[UIImage class]]) {
            NSAssert([object isKindOfClass:[UIImage class]], @"Exception: bannerview datasource must be UIImage class");
        }
    }
    if (_remoteImageType == NO) {
        _imageArray = [names copy];
    }
}
- (void)setDataSource:(NSArray *)dataSources {
    if (dataSources && dataSources.count > 0) {
        _numbersOfImages = dataSources.count;
        _scrollView.contentSize = CGSizeMake(_kWidth * dataSources.count, 0);
        _scrollView.delegate = self;
        if ([dataSources.firstObject isKindOfClass:[UIImage class]]) {
            _remoteImageType = NO;
//            [self c:dataSources.count];
//            [_imageArray removeAllObjects];
//            dataSources = [_imageArray copy];
            [self.imageArray addObjectsFromArray:dataSources];
//            [self setupDefaultValues:dataSources.count];
            //        [self confirgueScrollView];
            [self setImageData:self.imageArray];
            [self setNumbersOfImage:dataSources.count];
        }else{
            _remoteImageType = YES;
//            [_urlStringSources removeAllObjects];
//            _urlStringSources = [dataSources copy];
            [self.urlStringSources removeAllObjects];
            self.urlStringSources = [dataSources mutableCopy];
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
    if (autoBanner == NO) {
        _autoBanner = NO;
        [self removeTimer];
    }
}
#pragma mark implentation method
- (void)changeImageLeft:(NSInteger)leftIndex middle:(NSInteger)middleIndex right:(NSInteger)rightIndex{
    if (_imageArray.count == 0)return;
    if (_numbersOfImages == 1) {
        leftIndex = middleIndex = rightIndex = 0;
    }
    _leftImageView.image   = _imageArray[leftIndex];
    _middleImageView.image = _imageArray[middleIndex];
    _rightImageView.image  = _imageArray[rightIndex];
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
    NSLog(@"autoscroll");
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
        [self.imageArray setObject:[UIImage imageWithData:data] atIndexedSubscript:index];
    }else{
        [NSURLConnection  sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if (!connectionError) {
                UIImage *image = [UIImage imageWithData:data];
                if (!image) return ;
                [self.imageArray setObject:image atIndexedSubscript:index];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    if([SDHelper saveBannerCache:data WithIdentifier:url.absoluteString]){
                    };
                });
            }
        }];
    }
}
#pragma mark - public
- (void)clearBannerCache{
    [SDHelper clearBannerCache];
}
@end
