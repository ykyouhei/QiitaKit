Pod::Spec.new do |s|
  s.name         = "QiitaKit"
  s.version      = "1.0.0"
  s.summary      = "A Swift API Client for Qiita"
  s.homepage     = "https://github.com/ykyouhei/QiitaKit"
  s.license      = "MIT"
  s.author       = { "Kyohei Yamaguchi" => "kyouhei.lab@gmail.com" }
  s.social_media_url   = "https://twitter.com/kyo__hei"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/ykyouhei/QiitaKit.git", :tag => s.version.to_s }
  s.source_files = "QiitaKit/Sources/**/*.swift"
  s.requires_arc = true
  s.ios.deployment_target = '10.0'
end
