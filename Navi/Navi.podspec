Pod::Spec.new do |s|

  s.name         = 'Navi'
  s.version      = '0.2.4'
  s.summary      = 'This is a tool which could easily observe and visualize each route and flow we are tracking on the real time.'
  s.description  = "For a big App, sometime it's hard to check and debug which route we are using. what reaction will be happened once we click somewhere. in order to easily check those scenario whether or not meet the expectation, this tool is created to tackle this requirement."
  s.homepage     = 'https://github.com/AppScaffold/Navi' 
  s.license      = 'MIT'
  s.platform     = :ios, '9.0'
  s.swift_version = '4.2'
  s.source       = { 'https://github.com/AppScaffold/Navi.git', :tag => s.version }
  s.source_files  = 'Navi/**/*.{h,m,swift}'
  s.exclude_files = 'Navi/NaviTests/'
  s.public_header_files = 'Navi/Navi.h', 'Navi/AllTouchesGestureRecognizer.h'
  s.author         = 'AppScaffold'
  
end
