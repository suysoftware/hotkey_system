#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint hotkey_system.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
    s.name             = 'hotkey_system'
    s.version          = '0.0.1'
    s.summary          = 'A new flutter plugin project.'
    s.description      = <<-DESC
  A new flutter plugin project.
                         DESC
    s.homepage         = 'suy.development@gmail.com'
    s.license          = { :file => '../LICENSE' }
    s.author           = { 'Sezer Ufuk Yavuz' => 'suy.development@gmail.com' }
    s.source           = { :path => '.' }
    s.source_files     = 'Classes/**/*'
    s.dependency 'FlutterMacOS'
    s.dependency 'HotKey'
  
    s.platform = :osx, '10.14'
    s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
    s.swift_version = '5.0'
  end