#
# Be sure to run `pod lib lint BobPullToRefresh.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BobPullToRefresh"
  s.version          = "1.0.0"
  s.summary          = "A basic iOS pull to refresh control."
  s.homepage         = "https://github.com/bobthekingofegypt/BobPullToRefresh"
  s.license          = 'MIT'
  s.author           = { "bob" => "bobthekingofegypt@googlemail.com" }
  s.source           = { :git => "https://github.com/bobthekingofegypt/BobPullToRefresh.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'BobPullToRefresh/Classes'

  s.dependency 'KVOController', '~> 1.0.1'
end
