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
- (instancetype)initWithMaxScale:(TKMapScale)maxMetersPerDevicePoint;
@property (readonly, nonatomic) TKMapScale maxMetersPerDevicePoint;
@end

@implementation TKVisibilityConstraint

+ (TKVisibilityConstraint *)constraintWithMaxAltitude:(CLLocationDistance)maxAltitude
{
    return [[TKAltitudeVisibilityConstraint alloc] initWithMaxAltitude:maxAltitude];
}

+ (TKVisibilityConstraint *)constraintWithMaxScale:(TKMapScale)maxMetersPerDevicePoint
{
    return [[TKScaleVisibilityConstraint alloc] initWithMaxScale:maxMetersPerDevicePoint];
}

- (BOOL)shouldShowInContext:(TKVisibilityContext)context
{
    return YES;
}

- (BOOL)shouldShowAnnotation:(id<MKAnnotation>)annotation inContext:(TKVisibilityContext)context
{
    return [self shouldShowInContext:context];
}

- (BOOL)shouldShowOverlay:(id <MKOverlay>)overlay inContext:(TKVisibilityContext)context
{
    return [self shouldShowInContext:context];
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

- (instancetype)initWithMaxScale:(TKMapScale)maxMetersPerDevicePoint
{
    if (self = [super init]) {
        _maxMetersPerDevicePoint = maxMetersPerDevicePoint;
    }
    return self;
}

- (BOOL)shouldShowInContext:(TKVisibilityContext)context
{
    return context.scale <= self.maxMetersPerDevicePoint;
}

@end
