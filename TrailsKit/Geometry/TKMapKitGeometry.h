//
//  TKMapKitGeometry.h
//  TrailsKit
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TrailsKitTypes.h"

#define MKCoordinateRegionZero MKCoordinateRegionMake(CLLocationCoordinate2DMake(0, 0), MKCoordinateSpanMake(0, 0))

@class TKVisibilityConstraint;

NSString *NSStringFromCLLocationCoordinate2D(CLLocationCoordinate2D coordinate);

/**
 * Construct a region enclosing an array of CLLocationCoordinate2D values.
 */
MKCoordinateRegion MKCoordinateRegionFromCoordinates(NSArray* coordinates);

MKCoordinateRegion MKCoordinateRegionFromCorners(CLLocationCoordinate2D SW, CLLocationCoordinate2D NE);

BOOL MKCoordinateRegionIsZero(MKCoordinateRegion region);

MKMapRect TKMKMapRectFromCoordinateRegion(MKCoordinateRegion region);

NSString* NSStringFromMKCoordinateRegion(MKCoordinateRegion region);

@protocol TKHasVisibilityConstraint <NSObject>
-(TKVisibilityConstraint *)visibilityConstraint;
@end

@interface NSNumber (TKMapKitGeometry)
- (CLLocationDegrees)tk_degreesValue;
- (CLLocationDistance)tk_distanceValue;
- (TKMapScale)tk_mapScaleValue;
@end
