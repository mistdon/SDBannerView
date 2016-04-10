# SDBannerView
Powerful banner view, support for local and remote image,data cache.

##CocoaPods
```
pod 'SDBannerView'
```

###ScreenShot

![image](https://github.com/momo13014/SDBannerView/blob/master/screenshot/SDBannerViewsShot.gif)
###Requirements

* Xcode 5 or higher
* iOS 7.0 or higher
* ARC

###Fetures
[ x ] Local or remote image
[ x ] Data cache
[ x ] lot of styles

###How to use

After pod install,add below code where you use it.
```
 #import <SDBannerView.h>
```

###Demo
You can set the source image array with local or remote source;

```
- (instancetype)initWithFrame:(CGRect)frame
```
After you create it, you can set or change the imagesource by Property 'datasource'
Here is a example:
```
NSString *urlStr1 = @"http://d.3987.com/xingg_141230/003.jpg";
NSString *urlStr2 = @"http://www.bz55.com/uploads/allimg/150306/139-1503060UK3.jpg";
NSString *urlStr3 = @"http://file.mumayi.com/forum/201307/19/150111rgcjujqz2qryuc9q.jpg";
NSString *urlStr4 = @"http://pic.4j4j.cn/upload/pic/20150415/8a2db241e0.jpg";
NSString *urlStr5 = @"http://image.tianjimedia.com/uploadImages/2013/319/B23IL333AL14_1000x500.jpg";
NSArray *arr = @[urlStr1,urlStr2,urlStr3,urlStr4,urlStr5];
SDBannerView *banner = [[SDBannerView alloc] initWithFrame:CGRectMake(0, 480, self.view.bounds.size.width, 220)];
banner.datasource = arr;
banner.ScrollStyleAnimation = SDScrollStyleAnimationPagCurl;
[banner setPageType:PageControlPositionDownCenter];
[banner setCurrentIndexDidTap:^(NSInteger index) {
    NSLog(@"index = %ld",index);
}];
[self.view addSubview:banner];;
```
If you want to remove it, just use below code, all memory will be released.

```
- (void)removeFromSuperview;
```
###Suggestions?
If you have any suggestions, Please contac me.

###Contact Me
You can reach me anytime at the address below.

Github: [momo13014](https://github.com/momo13014)

Email : momo13014@163.com
###License

MIT License
