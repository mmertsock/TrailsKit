//
//  TKMapKitGeometry.m
//  RocTrails
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import "TKMapKitGeometry.h"

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

NSString* NSStringFromMKCoordinateRegion(MKCoordinateRegion region)
{
    return [NSString stringWithFormat:@"<region (%2.5f,%2.5f), (%2.5fx%2.5f)>",
            region.center.latitude,
            region.center.longitude,
            region.span.latitudeDelta,
            region.span.longitudeDelta];
}