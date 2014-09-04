//
//  TKMapKitGeometry.m
//  TrailsKit
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import "TKMapKitGeometry.h"

NSString *NSStringFromCLLocationCoordinate2D(CLLocationCoordinate2D coordinate)
{
    if (!CLLocationCoordinate2DIsValid(coordinate))
        return @"(invalid)";
    return [NSString stringWithFormat:@"(%f, %f)", coordinate.latitude, coordinate.longitude];
}

MKCoordinateRegion MKCoordinateRegionFromCoordinates(NSArray* coordinates)
{
    if (!coordinates.count) return MKCoordinateRegionZero;
    
    CLLocationCoordinate2D SW = CLLocationCoordinate2DMake(90, 180);
    CLLocationCoordinate2D NE = CLLocationCoordinate2DMake(-90, -180);
    
    for (NSValue* value in coordinates) {
        CLLocationCoordinate2D coord = value.MKCoordinateValue;
        SW.latitude = MIN(SW.latitude, coord.latitude);
        SW.longitude = MIN(SW.longitude, coord.longitude);
        NE.latitude = MAX(NE.latitude, coord.latitude);
        NE.longitude = MAX(NE.longitude, coord.longitude);
    }
    
    return MKCoordinateRegionFromCorners(SW, NE);
}

MKCoordinateRegion MKCoordinateRegionFromCorners(CLLocationCoordinate2D SW, CLLocationCoordinate2D NE)
{
    CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake(0.5 * (SW.latitude + NE.latitude), 0.5 * (SW.longitude + NE.longitude));
    MKCoordinateSpan span = MKCoordinateSpanMake(NE.latitude - SW.latitude, NE.longitude - SW.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoord, span);
    return region;
}

BOOL MKCoordinateRegionIsZero(MKCoordinateRegion region)
{
    return region.center.latitude == 0
        && region.center.longitude == 0
        && region.span.latitudeDelta == 0
        && region.span.longitudeDelta == 0;
}

MKMapRect TKMKMapRectFromCoordinateRegion(MKCoordinateRegion region)
{
    // MKMapPoint origin is at NW corner
    MKMapPoint NW = MKMapPointForCoordinate(CLLocationCoordinate2DMake(region.center.latitude + 0.5 * region.span.latitudeDelta, region.center.longitude - 0.5 * region.span.longitudeDelta));
    MKMapPoint SE = MKMapPointForCoordinate(CLLocationCoordinate2DMake(region.center.latitude - 0.5 * region.span.latitudeDelta, region.center.longitude + 0.5 * region.span.longitudeDelta));
    return MKMapRectMake(NW.x, NW.y, SE.x - NW.x, SE.y - NW.y);
}

NSString* NSStringFromMKCoordinateRegion(MKCoordinateRegion region)
{
    return [NSString stringWithFormat:@"<region (%2.5f,%2.5f), (%2.5fx%2.5f)>",
            region.center.latitude,
            region.center.longitude,
            region.span.latitudeDelta,
            region.span.longitudeDelta];
}

@implementation NSNumber (TKMapKitGeometry)

- (CLLocationDegrees)tk_degreesValue
{
    return [self doubleValue];
}

- (CLLocationDistance)tk_distanceValue
{
    return [self doubleValue];
}

- (TKMapScale)tk_mapScaleValue
{
    return [self doubleValue];
}

@end
