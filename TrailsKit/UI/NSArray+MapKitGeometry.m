//
//  NSArray+MapKitGeometry.m
//  RocTrails
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import "NSArray+MapKitGeometry.h"
#import "TKPinAnnotation.h"

@implementation NSArray (MapKitGeometry)

- (NSArray *)coordinatesOfAnnotations
{
     NSMutableArray* coords = [[NSMutableArray alloc] initWithCapacity:self.count];
     for (TKPinAnnotation* annotation in self) {
         [coords addObject:[NSValue valueWithMKCoordinate:annotation.coordinate]];
     }
    return coords;
}

@end
