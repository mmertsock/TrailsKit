//
//  NSArray+MapKitGeometry.m
//  RocTrails
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import "NSArray+MapKitGeometry.h"
#import <MapKit/MapKit.h>
#import <NSArray+Functional/NSArray+Functional.h>

@implementation NSArray (MapKitGeometry)

- (NSArray *)coordinatesOfAnnotations
{
    return [self mapUsingBlock:^(id<MKAnnotation> annotation){
        return [NSValue valueWithMKCoordinate:annotation.coordinate];
    }];
}

- (CLLocationCoordinate2D*)cArrayOfLocationCoordinates
{
    if (self.count == 0) return NULL;
    CLLocationCoordinate2D* clcoords = (CLLocationCoordinate2D*)
    malloc(sizeof(CLLocationCoordinate2D)*self.count);
    NSUInteger ci = 0;
    for (CLLocation* coord in self) {
        clcoords[ci++] = coord.coordinate;
    }
    return clcoords;
}

@end
