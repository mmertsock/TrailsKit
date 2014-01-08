//
//  TKVisibilityConstraints.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/8/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "TKVisibilityConstraints.h"
#import <MapKit/MapKit.h>

@interface TKAltitudeVisibilityConstraints : TKVisibilityConstraints
- (id)initWithMaxAltitude:(CLLocationDistance)maxAltitude;
@property (readonly, nonatomic) CLLocationDistance maxAltitude;
@end

@implementation TKVisibilityConstraints

+ (TKVisibilityConstraints *)constraintsWithMaxAltitude:(CLLocationDistance)maxAltitude
{
    return [[TKAltitudeVisibilityConstraints alloc] initWithMaxAltitude:maxAltitude];
}

- (BOOL)shouldHideInMapView:(MKMapView *)mapView
{
    return NO;
}

@end

@implementation TKAltitudeVisibilityConstraints

- (id)initWithMaxAltitude:(CLLocationDistance)maxAltitude
{
    if (self = [super init]) {
        _maxAltitude = maxAltitude;
    }
    return self;
}

- (BOOL)shouldHideInMapView:(MKMapView *)mapView
{
    return mapView.camera.altitude > self.maxAltitude;
}

@end
