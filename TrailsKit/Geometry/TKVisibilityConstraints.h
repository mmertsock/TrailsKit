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

- (BOOL)shouldShowInMapView:(MKMapView *)mapView;

@end
