//
//  TKStyledPolygonArea.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/18/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKStyledPolygonArea.h"

@implementation TKStyledPolygonArea

+ (instancetype)polygonWithPointsFromPolyline:(MKPolyline *)polyline
                                        style:(TKShapeStyle *)aStyle
                                   constraint:(TKVisibilityConstraint *)visibilityConstraint
{
    MKPolygon* overlay = [MKPolygon polygonWithPoints:polyline.points
                                                count:polyline.pointCount];
    return [[self alloc] initWithOverlay:overlay style:aStyle constraint:visibilityConstraint];
}

- (id)initWithOverlay:(MKPolygon *)anOverlay
                style:(TKShapeStyle *)aStyle
           constraint:(TKVisibilityConstraint *)visibilityConstraint
{
    if (self = [super init]) {
        _overlay = anOverlay;
        _shapeStyle = aStyle;
        _visibilityConstraint = visibilityConstraint;
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
