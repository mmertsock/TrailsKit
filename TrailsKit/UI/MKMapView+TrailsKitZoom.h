//
//  MKMapView+TrailsKitZoom.h
//  TrailsKit
//
//  Created by Mike Mertsock on 9/3/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "TrailsKitGeometry.h"

@interface MKMapView (TrailsKitZoom)

- (TKMapScale)tk_metersPerDevicePoint;

- (TKMapScale)tk_metersPerDevicePointAtLatitude:(CLLocationDegrees)latitude;

@end
