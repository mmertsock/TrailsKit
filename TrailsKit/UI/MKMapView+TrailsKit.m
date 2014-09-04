//
//  MKMapView+TrailsKit.m
//  TrailsKit
//
//  Created by Mike Mertsock on 9/3/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "MKMapView+TrailsKit.h"

@implementation MKMapView (TrailsKit)

- (TKMapScale)tk_metersPerDevicePoint
{
    return [self tk_metersPerDevicePointAtAltitude:self.camera.altitude];
}

- (TKMapScale)tk_metersPerDevicePointAtAltitude:(CLLocationDistance)altitude
{
    return altitude / self.bounds.size.height;
}

- (TKVisibilityContext)tk_visibilityContext
{
    return (TKVisibilityContext) {
        .altitude = self.camera.altitude,
        .scale = self.tk_metersPerDevicePoint
    };
}

- (TKVisibilityContext)tk_visibilityContextForRegion:(MKCoordinateRegion)region
{
    MKMapRect rect = [self mapRectThatFits:TKMKMapRectFromCoordinateRegion(region)];
    CLLocationDistance metersPerMapPoint = MKMetersPerMapPointAtLatitude(region.center.latitude);
    CLLocationDistance radiusMeters = 0.5 * metersPerMapPoint * rect.size.height;
    
    // MKMapCamera has an viewing angle of about 30°
    // Given R = radius of region to view, in meters, the target altitude A is:
    // tan 15° = R/A; A = R / tan 15°
    const double radians15 = 0.261799387799149;
    TKVisibilityContext newContext = (TKVisibilityContext) { .altitude = 0, .scale = 0 };
    newContext.altitude = radiusMeters / tan(radians15);
    newContext.scale = [self tk_metersPerDevicePointAtAltitude:newContext.altitude];
    return newContext;
}

@end
