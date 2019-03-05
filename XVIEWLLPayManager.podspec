#
# Be sure to run `pod lib lint XVIEWLLPayManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XVIEWLLPayManager'
  s.version          = '0.2.8'
  s.summary          = '连连支付'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/xiaheng666/XVIEWLLPayManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaheng666' => 'key@xiaheng.net' }
  s.source           = { :git => 'git@github.com:xiaheng666/XVIEWLLPayManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  #s.static_framework = true
  
  s.ios.deployment_target = '8.0'
  
  s.source_files = 'XVIEWLLPayManager/Classes/*{.h,m}'
  
  s.ios.vendored_libraries = 'XVIEWLLPayManager/Classes/*.a'
  # s.ios.vendored_frameworks = 'XVIEWLLPayManager/Classes/libXVIEWLLPayManager.a'
  # s.resource_bundles = {
  #  'XVIEWLLPayManager' => ['XVIEWLLPayManager/Assets/*.bundle']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'LLMPay'
   #s.pod_target_xcconfig = {
   #   'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/libXVIEWLLPayManager',
   #   'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
   #}
   
end
