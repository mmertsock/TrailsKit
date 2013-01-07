//
//  TKPolyline.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/5/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKPolyline.h"
#import "NSArray+MapKitGeometry.h"

@implementation TKPolyline

+ (instancetype)polylineWithLocations:(NSArray*)clLocations
                                color:(UIColor*)color
{
    if (!clLocations.count) return nil;
    CLLocationCoordinate2D* coords = [clLocations cArrayOfLocationCoordinates];
    id polyline = [MKPolyline polylineWithCoordinates:coords count:clLocations.count];
    if (coords) free(coords);
    return [[self alloc] initWithPolyline:polyline color:color];
}

- (id)initWithPolyline:(MKPolyline *)polyline
                 color:(UIColor*)color
{
    if (self = [super init]) {
        self.polyline = polyline;
        self.color = color;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.polyline.coordinate;
}

- (MKMapRect)boundingMapRect
{
    return self.polyline.boundingMapRect;
}

@end
