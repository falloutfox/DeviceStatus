# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

def shared_pods
	pod 'RealmSwift'
end

target 'DeviceStatus' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  shared_pods
end

target 'DeviceStatusTests' do
    inherit! :search_paths
    shared_pods
  end