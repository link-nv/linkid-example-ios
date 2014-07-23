Pod::Spec.new do |s|
  s.name         = "LinkIDSDK"
  s.version      = "0.0.1"
  s.summary      = "linkID SDK integration library."
  s.homepage     = "https://www.linkid.be"
  s.license      = { :type => 'LGPL v3', :file => 'LICENSE' }
  s.author       = { "Wim Vandenhaute" => "wim.vandenhaute@gmail.com" }
  s.platform     = :ios, '5.1'
  s.source       = { :git => "https://github.com/link-nv/linkid-sdk-ios.git", :tag => "0.0.1" }
 
  s.ios.deployment_target = '5.1'
  s.ios.source_files  = 'linkid-sdk-ios/linkid-sdk-ios/*.{h,m}'
  s.ios.frameworks  = 'Security', 'MobileCoreServices', 'SystemConfiguration'
  s.ios.resources = ["linkid-sdk-ios/linkid-sdk-ios/*.png"]

  s.requires_arc = true

  s.ios.dependency 'Base64nl',   '~> 1.2'

end
