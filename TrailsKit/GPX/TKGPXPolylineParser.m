//
//  TKGPXPolylineParser.m
//  GPXTest
//
//  Created by Mike Mertsock on 1/6/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKGPXPolylineParser.h"
#import "TKShapeStyle.h"
#import "TKStyledPolyline.h"
#import <GPXParser/GPXParser.h>
#import <NSArray+Functional/NSArray+Functional.h>

@implementation TKGPXPolylineParser

- (NSArray*)overlaysFromGPX:(GPX*)gpx
{
    NSArray* polylines = [gpx.tracks mapUsingBlock:^(Track* track) {
        TKStyledPolyline* polyline = [[TKStyledPolyline alloc]
                                      initWithPolyline:track.path
                                      style:self.shapeStyle];
        return polyline;
    }];
    return polylines;
}

- (void)parseData:(NSData*)gpxData
       completion:(TKOverlayCompletionHandler)completionHandler
{
    __weak __typeof(&*self)weakSelf = self;
    [GPXParser parse:gpxData completion:^(BOOL success, GPX *gpx) {
        NSArray* polylines = success ? [weakSelf overlaysFromGPX:gpx] : nil;
        completionHandler(polylines != nil, polylines);
    }];
}

@end
