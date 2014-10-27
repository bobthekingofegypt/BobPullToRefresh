source 'https://github.com/CocoaPods/Specs'

xcodeproj "BobPullToRefresh.xcodeproj"

link_with ['BobPullToRefresh', 'BobPullToRefreshTests', 'Demo']

target 'BobPullToRefresh', :exclusive => true do
  pod 'KVOController'
end

target 'Demo', :exclusive => true do
  pod 'KVOController'
end

target 'BobPullToRefreshTests', :exclusive => true do
  pod 'KVOController'
  pod 'Specta', :git => 'https://github.com/specta/specta.git', :tag => 'v0.3.0.beta1'
  pod 'Expecta'
  pod 'OCMock'
  pod 'FBSnapshotTestCase'
end
