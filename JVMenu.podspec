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
  s.summary          = 'A simple bottom menu.'
  s.description      = 'This menu will try to mimic a custom action sheet coming either from the top of the view or the bottom of the view. Written in Swift.'
  s.homepage         = 'https://github.com/JV17/JVMenu'
  s.screenshots     = 'https://github.com/JV17/JVMenu/blob/master/Resources/demo-screen.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JV17' => 'jorge.valbuena@jorgedeveloper.com' }
  s.source           = { :git => 'https://github.com/JV17/JVMenu.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jvdev17'
  s.swift_version    = '5.0'
  s.ios.deployment_target = '13.4'
  s.platform         = :ios, '13.4'
  s.source_files = 'JVMenu/Classes/**/*.{swift}'
  s.ios.framework  = 'UIKit', 'Foundation'
end
