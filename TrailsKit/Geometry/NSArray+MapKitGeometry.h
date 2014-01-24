//
//  NSArray+MapKitGeometry.h
//  RocTrails
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSArray (MapKitGeometry)

/**
 * Given an array of id<MKAnnotation>, returns an array of NSValues
 * representing CLLocationCoordinate2Ds.
 */
- (NSArray*)tk_coordinatesOfAnnotations;

/**
 * Given an array of CLLocations, returns a C array representation
 * of the coordinates in this NSArray. Returns NULL if this array is
 * empty/nil. Otherwise returns a malloc'ed C array that must be free'd
 * after use.
 */
- (CLLocationCoordinate2D*)tk_CArrayOfLocationCoordinates;

@end
