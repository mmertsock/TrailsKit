//
//  TKVisibilityConstraint.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/8/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "TrailsKitGeometry.h"

@class MKMapView;

typedef struct {
    CLLocationDistance altitude;
    TKMapScale scale;
} TKVisibilityContext;

@interface TKVisibilityConstraint : NSObject

+ (TKVisibilityConstraint *)constraintWithMaxAltitude:(CLLocationDistance)maxAltitude;

+ (TKVisibilityConstraint *)constraintWithMinScale:(TKMapScale)minMetersPerDevicePoint;

// shouldHide instead of shouldShow so that sending
// this message to a nil constraint object returns
// a sensible value for most situations.
- (BOOL)shouldHideInMapView:(MKMapView *)mapView;

- (BOOL)shouldHideInContext:(TKVisibilityContext)context;

@end
