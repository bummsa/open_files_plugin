Pod::Spec.new do |s|
  s.name             = 'open_files_plugin'
  s.version          = '0.0.2'
  s.summary          = 'A Flutter plugin to count the number of open files on iOS.'
  s.description      = <<-DESC
                       A Flutter plugin to count the number of open files on iOS.
                       DESC
  s.homepage         = 'https://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Name' => 'your.email@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.swift_version = '5.0'
  s.platform     = :ios, '9.0'
end
