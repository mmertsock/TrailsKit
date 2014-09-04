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
    return [self tk_metersPerDevicePointAtLatitude:self.centerCoordinate.latitude];
}

- (TKMapScale)tk_metersPerDevicePointAtLatitude:(CLLocationDegrees)latitude
{
    CLLocationDistance mapPointsPerScreenPoints = self.visibleMapRect.size.width / self.bounds.size.width;
    CLLocationDistance metersPerMapPoint = MKMetersPerMapPointAtLatitude(latitude);
    return mapPointsPerScreenPoints * metersPerMapPoint;
}

- (TKVisibilityContext)tk_visibilityContext
{
    return (TKVisibilityContext) {
        .altitude = self.camera.altitude,
        .scale = self.tk_metersPerDevicePoint
    };
}

@end
