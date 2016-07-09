# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Magazine' do
  # Uncomment this line if you're using Swift or would like to use dynamic frameworks
  use_frameworks!
  pod "NAChloride"
  pod "WYMaterialButton"

  # Pods for Magazine
post_install do |installer|
  installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
    configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
  end
end

end
