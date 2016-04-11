Pod::Spec.new do |s|
  s.name         = "SDBannerView"
  s.version      = "1.0"
  s.framework    = "UIKit"
  s.summary      = "The package of banner view, support image cache"
  s.homepage     = "http://www.jianshu.com/users/09dd259f9e1c"
  s.license      = "MIT"
  s.authors      = { 'Allen' => 'momo13014@163.com'}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/momo13014/SDBannerView.git", :tag => s.version }
  s.source_files = 'SDBannerView', 'SDBannerView/**/*.{h,m}'
  s.requires_arc = true
end
