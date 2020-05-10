#
# Be sure to run `pod lib lint JVMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JVMenu'
  s.version          = '0.1.0'
  s.summary          = 'A simple bottom/top drop-down/pop-up menu.'
  s.description      = "This menu will try to mimic a custom action sheet coming either from the top of the view or the bottom of the view. Written in Swift."

  s.homepage         = 'https://github.com/JV17/JVMenu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JV17' => 'jorge.valbuena@jorgedeveloper.com' }
  s.source           = { :git => 'https://github.com/JV17/JVMenu.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JVMenu/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JVMenu' => ['JVMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
