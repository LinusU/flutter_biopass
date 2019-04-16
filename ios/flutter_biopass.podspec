#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_biopass'
  s.version          = '0.1.0'
  s.summary          = 'Store a password behind biometric authentication.'
  s.description      = <<-DESC
Store a password behind biometric authentication.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'BioPass', '~> 2.0'

  s.ios.deployment_target = '9.0'
end
