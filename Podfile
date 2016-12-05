# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Bands' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Bands
    pod 'Alamofire', '~> 4.0'
    pod 'Charts'
    pod 'Gloss', '~> 1.1'
    pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
    pod 'Kingfisher', '~> 3.0'
    pod 'RealmSwift'
    pod 'SwiftSpinner'
    pod 'SwiftyJSON'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0' # or '3.0'
        end
    end
end
