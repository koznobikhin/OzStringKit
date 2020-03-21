Pod::Spec.new do |s|
    s.name           = 'OzStringKit'
    s.version        = '0.0.6'
    s.summary        = 'NSAttributedString creation with Swift 5 string interpolation.'
    s.homepage       = 'https://github.com/koznobikhin/OzStringKit'
    s.license        = { :type => 'MIT' }
    s.author         = { 'Konstantin Oznobikhin' => 'koznobikhin@users.noreply.github.com' }
    s.source         = { :git => 'https://github.com/koznobikhin/OzStringKit.git', :tag => s.version.to_s }
    s.frameworks     = 'Foundation'
    s.osx.frameworks = 'AppKit'
    s.ios.frameworks = 'UIKit'
    s.watchos.frameworks = 'UIKit'
    s.tvos.frameworks = 'UIKit'

    s.ios.deployment_target = '10.0'
    s.osx.deployment_target = '10.11'
    s.watchos.deployment_target = '2.0'
    s.tvos.deployment_target = '9.0'

    s.source_files   = 'Sources/OzStringKit/**/*.swift'
    s.exclude_files  = 'iOS Example/**/*.*', 'Tests/**/*.swift'

    s.swift_version = "5.0"

    s.description      = <<-DESC
OzStringKit leverages ExpressibleByStringInterpolation API from Swift 5
to allow creation of NSAttributedString objects with simple and concise syntax.
                         DESC

    s.screenshots     = 'https://github.com/koznobikhin/OzStringKit/raw/master/demo.png'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
end
