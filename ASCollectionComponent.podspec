#
# Be sure to run `pod lib lint ASCollectionComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ASCollectionComponent'
  s.version          = '0.2.0'
  s.summary          = 'A short description of ASCollectionComponent.'
  s.homepage         = 'https://github.com/arcangelw/ASCollectionComponent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'arcangelw' => 'wuzhezmc@gmail.com' }
  s.source           = { :git => 'https://github.com/arcangelw/ASCollectionComponent.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.source_files = 'ASCollectionComponent/Classes/**/*.{h,m,mm,swift}'
  s.public_header_files = 'ASCollectionComponent/Classes/*.h'
  s.private_header_files = 'ASCollectionComponent/Classes/Private/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'Texture/Core'
  s.user_target_xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC',
    'VALID_ARCHS' => 'x86_64 armv7 arm64'
  }
end
