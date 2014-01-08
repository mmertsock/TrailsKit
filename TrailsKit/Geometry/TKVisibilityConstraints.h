//
//  TKVisibilityConstraints.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/8/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class MKMapView;

@interface TKVisibilityConstraints : NSObject

+ (TKVisibilityConstraints *)constraintsWithMaxAltitude:(CLLocationDistance)maxAltitude;

// shouldHide instead of shouldShow so that sending
// this message to a nil constraints object returns
// a sensible value for most situations.
- (BOOL)shouldHideInMapView:(MKMapView *)mapView;

@end
