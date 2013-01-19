//
//  TKGPXPolylineParser.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/6/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKGPXPolylineMapper.h"
#import "TKStyledPolyline.h"
#import <NSArray+Functional/NSArray+Functional.h>
#import <GPXParser/GPXParser.h>

@implementation TKGPXPolylineMapper

- (id)initWithStyle:(TKShapeStyle*)aStyle
{
    if (self = [super init]) {
        _shapeStyle = aStyle;
    }
    return self;
}

- (NSArray *)mapOverlaysFromGPX:(GPX *)gpx
{
    NSArray* polylines = [gpx.tracks mapUsingBlock:^(Track* track) {
        TKStyledPolyline* polyline = [[TKStyledPolyline alloc]
                                      initWithPolyline:track.path
                                      style:self.shapeStyle];
        return polyline;
    }];
    return polylines;
}

@end
