#
#  Be sure to run `pod spec lint SDBannerView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SDBannerView"
  s.version      = "1.0.1"
  s.summary      = "Light banner view, support for changing datasource, image cache."
  s.description  = <<-DESC
          "Light banner view, support for changing datasource, image cache, support for CocoaPods and Carthage.
                  DESC
  s.homepage     = "https://github.com/momo13014/SDBannerView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = 'MIT'
  s.author       = { "shendong" => "shendong13014@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/momo13014/SDBannerView.git", :tag => "#{s.version}" }
  
  s.source_files = ['Classes/', 'Classes/Assets/*.png']
  # s.resources    = ['Classes/Assets/*.png']

  # s.public_header_files = 'Classes/*.h'


end
