Pod::Spec.new do |s|
    s.name           = 'OzStringKit'
    s.version        = '0.0.1'
    s.summary        = 'NSAttributedString creation with Swift 5 string interpolation.'
    s.homepage       = 'https://github.com/koznobikhin/OzStringKit'
    s.license        = { :type => 'MIT', :file => 'LICENSE' }
    s.author         = { 'Konstantin Oznobikhin' => 'koznobikhin@gmail.com' }
    s.source         = { :git => 'https://github.com/koznobikhin/OzStringKit.git', :tag => s.version.to_s }
    s.frameworks     = 'Foundation'

    s.ios.deployment_target = '10.0'

    s.source_files   = 'Sources/OzStringKit/**/*.swift'
    s.exclude_files  = 'iOS Example/**/*.*', 'Tests/**/*.swift'

    s.swift_version = "5.0"

    s.description      = <<-DESC
OzStringKit leverages ExpressibleByStringInterpolation API from Swift 5
to allow creation of NSAttributedString objects with simple and concise syntax.
                         DESC

  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
end
