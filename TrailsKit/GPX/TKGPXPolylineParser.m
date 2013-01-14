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

- (void)parseData:(NSData*)gpxData
       completion:(void(^)(BOOL, NSArray*))completionHandler
{
    [GPXParser parse:gpxData completion:^(BOOL success, GPX *gpx) {
        if (!success) {
            completionHandler(NO, nil);
            return;
        }
        
        NSArray* polylines = [gpx.tracks mapUsingBlock:^(Track* track) {
            TKStyledPolyline* polyline = [[TKStyledPolyline alloc]
                                          initWithPolyline:track.path
                                          style:self.shapeStyle];
            return polyline;
        }];
        
        completionHandler(YES, polylines);
    }];
}

@end
