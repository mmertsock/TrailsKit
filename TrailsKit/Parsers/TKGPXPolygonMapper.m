//
//  TKGPXPolygonMapper.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/19/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKGPXPolygonMapper.h"
#import "TKStyledPolygonArea.h"
#import <NSArray+Functional/NSArray+Functional.h>
#import <GPXParser/GPXParser.h>
#import <MapKit/MapKit.h>

@implementation TKGPXPolygonMapper

- (id)initWithStyle:(TKShapeStyle *)aStyle
defaultVisibilityConstraint:(TKVisibilityConstraint *)constraint
{
    if (self = [super init]) {
        _shapeStyle = aStyle;
        _defaultVisibilityConstraint = constraint;
    }
    return self;
}

- (NSArray *)mapOverlaysFromGPX:(GPX *)gpx
{
    NSArray *polygons = [gpx.tracks mapUsingBlock:^id(Track *track) {
        return [MKPolygon polygonWithPoints:track.path.points
                                      count:track.path.pointCount];
    }];
    
    if (self.treatMultipleTracksInFileAsInteriorPolygons
        && polygons.count > 1) {
        MKPolygon *topLevel = polygons.firstObject;
        id interiorPolygons = [polygons subarrayWithRange:NSMakeRange(1, polygons.count - 1)];
        topLevel = [MKPolygon polygonWithPoints:topLevel.points
                                          count:topLevel.pointCount
                               interiorPolygons:interiorPolygons];
        polygons = @[topLevel];
    }
    
    NSArray* tkPolygons = [polygons mapUsingBlock:^(MKPolygon *poly) {
        id polygon = [[TKStyledPolygonArea alloc]
                      initWithOverlay:poly
                      style:self.shapeStyle
                      constraint:self.defaultVisibilityConstraint];
        return polygon;
    }];
    return tkPolygons;
}

@end
