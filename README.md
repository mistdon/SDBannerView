# SDBannerView
powerful banner view, support for data cache

##CocoaPods
```
pod 'SDBannerView'
```

###ScreenShot

![image](https://github.com/momo13014/SDBannerView/blob/master/screenshot/SDBannerView.gif)
###Requirements

* Xcode 5 or higher
* iOS 8.0 or higher
* ARC

###How to use

After pod install,add below code when you use it.
```
 #import <SDBannerView.h>
```

###Demo
```
NSString *urlStr1 = @"http://img10.3lian.com/sc6/show02/67/27/02.jpg";
NSString *urlStr2 = @"http://img161.poco.cn/mypoco/myphoto/20100424/19/53310080201004241856521800459127582_005.jpg";
NSString *urlStr3 = @"http://img4.duitang.com/uploads/item/201408/30/20140830185433_FnJLA.jpeg";
NSString *urlStr4 = @"http://tupian.enterdesk.com/2013/xll/012/26/3/1.jpg";

SDBannerView *banner = [[SDBannerView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 250) urls:@[urlStr1,urlStr2,urlStr3,urlStr4]];
[banner setPageType:PageControlPositionDownCenter];
[banner setCurrentIndexDidTap:^(NSInteger index) {
NSLog(@"index = %ld",index);
}];
[self.view addSubview:banner];; 
```
