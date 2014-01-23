Pod::Spec.new do |s|
  s.name         = "TrailsKit"
  s.version      = "0.4.0"
  s.source       = { :git => "https://github.com/mmertsock/TrailsKit.git", :tag => "v#{s.version}" }
  s.summary      = "Tools for representing and displaying geographical data for parks and trails."
  s.homepage     = "https://github.com/mmertsock/TrailsKit"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "mmertsock"
  s.source_files = "TrailsKit/UI", "TrailsKit/*.h", "TrailsKit/Parsers", "TrailsKit/Geometry"
  s.requires_arc = true
  
  s.ios.deployment_target = "7.0"
  s.ios.frameworks = "MapKit", "CoreLocation", "CoreGraphics"
  s.dependency "GPXParser"
  s.dependency "NSArray+Functional"
end
