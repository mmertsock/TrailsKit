//
//  TKGPXPolylineParser.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/6/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKGPXPolylineMapper.h"
#import "TKStyledPolyline.h"
#import "GPX+TrailsKit.h"
#import <NSArray+Functional/NSArray+Functional.h>
#import <GPXParser/GPXParser.h>

@implementation TKGPXPolylineMapper

- (id)initWithStyle:(TKShapeStyle*)aStyle
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
    NSArray* polylines = [gpx.allTracks mapUsingBlock:^(Track* track) {
        id polyline = [[TKStyledPolyline alloc]
                       initWithPolyline:track.path
                       style:self.shapeStyle
                       constraint:self.defaultVisibilityConstraint
                       data:nil];
        return polyline;
    }];
    return polylines;
}

@end
