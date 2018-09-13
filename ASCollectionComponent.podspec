#
# Be sure to run `pod lib lint ASCollectionComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ASCollectionComponent'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ASCollectionComponent.'
  s.homepage         = 'https://github.com/arcangelw/ASCollectionComponent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'arcangelw' => 'wuzhezmc@gmail.com' }
  s.source           = { :git => 'https://github.com/arcangelw/ASCollectionComponent.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'ASCollectionComponent/Classes/**/*'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Texture'
end
