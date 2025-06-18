#
# Be sure to run `pod lib lint ScrollingFormHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScrollingFormHelper'
  s.version          = '0.3.0'
  s.summary          = 'A simple library to handle scrolling on forms that use the keyboard.'
  s.swift_versions   = '5.0'

  s.description      = <<-DESC
Use this library to handle one or multiple text fields that trigger the keyboard, so the whole scroll view content is still accessible.
                       DESC

  s.homepage         = 'https://github.com/lautarodelosheros/ScrollingFormHelper.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lautarodelosheros' => 'lautarodelosheros@gmail.com' }
  s.source           = { :git => 'https://github.com/lautarodelosheros/ScrollingFormHelper.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Sources/ScrollingFormHelper/Classes/**/*'
end
