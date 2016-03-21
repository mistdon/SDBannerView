Pod::Spec.new do |s|
# 名称 使用的时候pod search [name]
s.name = "SDBannerView"
# 代码库的版本
s.version = "0.0.1"
# 简介
s.summary = "Powerful, Easy to use banner view on controller and window, for iOS"
# 主页
s.homepage = "https://github.com/momo13014/SDBannerView"
# 许可证书类型，要和仓库的LICENSE 的类型一致
s.license = { :type => 'MIT', :file => 'LICENSE' }
# 作者名称 和 邮箱
s.author = { "Allen Shen" => "momo13014@163.com" }
# 作者主页 s.social_media_url =""
# 代码库最低支持的版本
s.platform = :ios, "7.0"
# 代码的Clone 地址 和 tag 版本
s.source = { :git => "https://github.com/momo13014/SDBannerView.git", :tag => "0.0.1" }
# 如果使用pod 需要导入哪些资源
s.source_files = "SDBannerView/**/*.{h,m}"
s.resources = "**/*/*.bundle"
# 框架是否使用的ARC
s.requires_arc = true
end
