//
//  TKVisibilityConstraint.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/8/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "TKVisibilityConstraint.h"
#import <MapKit/MapKit.h>
#import "MKMapView+TrailsKit.h"

@interface TKAltitudeVisibilityConstraint : TKVisibilityConstraint
- (id)initWithMaxAltitude:(CLLocationDistance)maxAltitude;
@property (readonly, nonatomic) CLLocationDistance maxAltitude;
@end

@interface TKScaleVisibilityConstraint : TKVisibilityConstraint
- (instancetype)initWithMinScale:(TKMapScale)minMetersPerDevicePoint;
@property (readonly, nonatomic) TKMapScale minMetersPerDevicePoint;
@end

@implementation TKVisibilityConstraint

+ (TKVisibilityConstraint *)constraintWithMaxAltitude:(CLLocationDistance)maxAltitude
{
    return [[TKAltitudeVisibilityConstraint alloc] initWithMaxAltitude:maxAltitude];
}

+ (TKVisibilityConstraint *)constraintWithMinScale:(TKMapScale)minMetersPerDevicePoint
{
    return nil;
}

- (BOOL)shouldShowInMapView:(MKMapView *)mapView
{
    return [self shouldShowInContext:mapView.tk_visibilityContext];
}

- (BOOL)shouldShowInContext:(TKVisibilityContext)context
{
    return YES;
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

- (BOOL)shouldShowInContext:(TKVisibilityContext)context
{
    return context.altitude <= self.maxAltitude;
}

@end

@implementation TKScaleVisibilityConstraint

- (instancetype)initWithMinScale:(TKMapScale)minMetersPerDevicePoint
{
    if (self = [super init]) {
        _minMetersPerDevicePoint = minMetersPerDevicePoint;
    }
    return self;
}

- (BOOL)shouldShowInContext:(TKVisibilityContext)context
{
    return context.scale >= self.minMetersPerDevicePoint;
}

@end

