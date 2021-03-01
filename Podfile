platform :ios, '14.0'
use_frameworks!

target 'RxRover' do
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'Cause-Logic-Effect'
    pod 'RxKingfisher'
end

target 'RxRoverTests' do
    pod 'RxTest'
    pod 'RxBlocking'
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
         target.build_configurations.each do |config|
            if config.name == 'Debug'
               config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
            end
         end
      end
   end
end
