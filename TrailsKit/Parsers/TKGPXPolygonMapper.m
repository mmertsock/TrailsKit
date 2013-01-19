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

@implementation TKGPXPolygonMapper

- (id)initWithStyle:(TKShapeStyle *)aStyle
{
    if (self = [super init]) {
        _shapeStyle = aStyle;
    }
    return self;
}

- (NSArray *)mapOverlaysFromGPX:(GPX *)gpx
{
    NSArray* polygons = [gpx.tracks mapUsingBlock:^(Track* track) {
        id polygon = [TKStyledPolygonArea
                      polygonWithPointsFromPolyline:track.path
                      style:self.shapeStyle];
        return polygon;
    }];
    return polygons;
}

@end
