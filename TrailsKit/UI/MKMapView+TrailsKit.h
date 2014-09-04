//
//  MKMapView+TrailsKit.h
//  TrailsKit
//
//  Created by Mike Mertsock on 9/3/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "TrailsKitGeometry.h"
#import "TKVisibilityConstraint.h"

@interface MKMapView (TrailsKit)

- (TKMapScale)tk_metersPerDevicePoint;

- (TKVisibilityContext)tk_visibilityContext;

- (TKVisibilityContext)tk_visibilityContextForRegion:(MKCoordinateRegion)region;

@end
