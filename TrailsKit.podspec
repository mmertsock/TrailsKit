Pod::Spec.new do |s|
  s.name = 'TrailsKit'
  s.version = '0.0.1'
  s.summary = 'Tools for representing and displaying geographical data for parks and trails.'
  s.homepage = 'https://github.com/mmertsock/TrailsKit'
  s.author = 'MM'
  
  s.requires_arc = true
  s.ios.deployment_target = '5.0'
  
  s.source_files = 'TrailsKit/UI', 'TrailsKit/*.h', 'TrailsKit/GPX', 'TrailsKit/Geometry'
  #'Classes', 'External/**/*.{h,m}'

  s.ios.frameworks = 'MapKit', 'CoreLocation'
  
end
