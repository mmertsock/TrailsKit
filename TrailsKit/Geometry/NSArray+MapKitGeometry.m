//
//  NSArray+MapKitGeometry.m
//  TrailsKit
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import "NSArray+MapKitGeometry.h"
#import <MapKit/MapKit.h>
#import "NSArray+Functional.h"

@implementation NSArray (MapKitGeometry)

- (NSArray *)tk_coordinatesOfAnnotations
{
    return [self mapUsingBlock:^(id<MKAnnotation> annotation){
        return [NSValue valueWithMKCoordinate:annotation.coordinate];
    }];
}

- (CLLocationCoordinate2D*)tk_CArrayOfLocationCoordinates
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
