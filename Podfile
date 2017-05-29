source 'https://github.com/CocoaPods/Specs.git'

platform :osx, '10.12'
use_frameworks!

target 'mitotte-client' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :tag => ‘4.3.0’
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
           config.build_settings['SWIFT_VERSION'] = '3.0'
       end
   end
end
