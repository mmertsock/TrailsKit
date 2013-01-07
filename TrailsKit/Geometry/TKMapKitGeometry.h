//
//  TKMapKitGeometry.h
//  RocTrails
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define MKCoordinateRegionZero MKCoordinateRegionMake(CLLocationCoordinate2DMake(0, 0), MKCoordinateSpanMake(0, 0))

/**
 * Construct a region enclosing an array of CLLocationCoordinate2D values.
 */
MKCoordinateRegion MKCoordinateRegionFromCoordinates(NSArray* coordinates);

BOOL MKCoordinateRegionIsZero(MKCoordinateRegion region);