//
//  NSArray+MapKitGeometry.h
//  RocTrails
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MapKitGeometry)

/**
 * Given an array of id<MKAnnotation>, returns an array of NSValues
 * representing CLLocationCoordinate2Ds.
 */
- (NSArray*)coordinatesOfAnnotations;

@end
