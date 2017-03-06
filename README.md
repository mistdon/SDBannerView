# SDBannerView

![Pod Version](https://img.shields.io/cocoapods/v/SDBannerView.svg?style=flat)
![Pod Platform](https://img.shields.io/cocoapods/p/SDBannerView.svg?style=flat)
![Pod License](https://img.shields.io/cocoapods/l/SDBannerView.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

'SDBannerView' is a simple, powerful banner view, support for data cached, by the way, you can load image from local or remote.

![SDBannerView]()
![image](https://github.com/momo13014/SDBannerView/blob/master/ScreenShots/SDBannerViewsShot.gif)
##Installation

###From Cocoapods


```ruby
pod 'SDBannerView'
```

If you want to use the latest features of `SDBannerView` use normal external source dependencies.

```ruby
pod 'SDBannerView', :git => 'https://github.com/SDBannerView/SDBannerView.git'
```

This pulls from the `master` branch directly.

Second, install `SDBannerView` into your project:

```ruby
pod install
```

### Carthage 

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate `SDBannerView` into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "SDBannerView/SDBannerView"
```

Run `carthage update` to build the framework and drag the built `SDBannerView.framework` (in Carthage/Build/iOS folder) into your Xcode project (Linked Frameworks and Libraries in `Targets`).


## Swift

Even though `SDBannerView` is written in Objective-C, it can be used in Swift with no hassle. If you use [CocoaPods](http://cocoapods.org) add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
use_frameworks!
```

If you added `SDBannerView` manually, just add a [bridging header](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html) file to your project with the `SDBannerView` header included. 

## Usage
(see sample Xcode porject in '/SDBannerView')

you can create it with hard code or xib.

Then you can set its images for SDBannerView. whatever local images or remote images

```
#import <SDBannerView/SDBannerView.h>

[banner setCurrentIndexDidTap:^(NSInteger index) {
    NSLog(@"index = %ld",index);
}];
[self.view addSubview:banner];
[banner setImages:array];
```

####Caution:

If you create it with XIB or Storyboard, just put the below code where -(void)willAppear or -(void)viewDidLoad;

```
self.automaticallyAdjustsScrollViewInsets = NO;

```


## License
TSMessages is available under the MIT license. See the LICENSE file for more information.

## Recent Changes
Can be found in the [releases section](https://github.com/momo13014/SDBannerView/releases) of this repo.
