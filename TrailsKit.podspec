Pod::Spec.new do |s|
  s.name = 'TrailsKit'
  s.version = '0.3.0'
  s.summary = 'Tools for representing and displaying geographical data for parks and trails.'
  s.homepage = 'https://github.com/mmertsock/TrailsKit'
  s.author = 'mmertsock'
  
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  
  s.source_files = 'TrailsKit/UI', 'TrailsKit/*.h', 'TrailsKit/Parsers', 'TrailsKit/Geometry'

  s.ios.frameworks = 'MapKit', 'CoreLocation', 'CoreGraphics'

  s.dependency 'GPXParser'
  s.dependency 'NSArray+Functional'
  
end
