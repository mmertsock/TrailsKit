//
//  TKStyledPolyline.m
//  GPXTest
//
//  Created by Mike Mertsock on 1/6/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKStyledPolyline.h"

@implementation TKStyledPolyline

- (id)initWithPolyline:(id<MKOverlay>)polyline
                 style:(TKShapeStyle*)aStyle
            constraint:(TKVisibilityConstraint *)visibilityConstraint
                  data:(id)data
{
    if (self = [super init])
    {
        _overlay = polyline;
        _shapeStyle = aStyle;
        _visibilityConstraint = visibilityConstraint;
        _data = data;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return [self.overlay coordinate];
}

- (MKMapRect)boundingMapRect
{
    return [self.overlay boundingMapRect];
}

@end
