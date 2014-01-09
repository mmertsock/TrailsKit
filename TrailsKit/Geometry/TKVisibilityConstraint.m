//
//  TKVisibilityConstraint.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/8/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "TKVisibilityConstraint.h"
#import <MapKit/MapKit.h>

@interface TKAltitudeVisibilityConstraint : TKVisibilityConstraint
- (id)initWithMaxAltitude:(CLLocationDistance)maxAltitude;
@property (readonly, nonatomic) CLLocationDistance maxAltitude;
@end

@implementation TKVisibilityConstraint

+ (TKVisibilityConstraint *)constraintWithMaxAltitude:(CLLocationDistance)maxAltitude
{
    return [[TKAltitudeVisibilityConstraint alloc] initWithMaxAltitude:maxAltitude];
}

- (BOOL)shouldHideInMapView:(MKMapView *)mapView
{
    return NO;
}

@end

@implementation TKAltitudeVisibilityConstraint

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
