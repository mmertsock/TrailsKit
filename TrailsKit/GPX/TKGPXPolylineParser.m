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

@implementation TKGPXPolylineParser

- (void)parseData:(NSData*)gpxData
       completion:(void(^)(BOOL, NSArray*))completionHandler
{
    [GPXParser parse:gpxData completion:^(BOOL success, GPX *gpx) {
        if (!success) {
            completionHandler(NO, nil);
            return;
        }
        NSMutableArray* polylines = [NSMutableArray arrayWithCapacity:gpx.tracks.count];
        for (Track* track in gpx.tracks) {
            TKStyledPolyline* polyline = [[TKStyledPolyline alloc]
                                          initWithPolyline:track.path
                                          style:self.shapeStyle];
            [polylines addObject:polyline];
        }
        completionHandler(YES, polylines);
    }];
}

- (void)loadURLAndParse:(NSURL*)url
             completion:(void (^)(BOOL, NSArray *))completionHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        [self parseData:data completion:completionHandler];
    });
}

- (void)loadPolylinesFromURL:(NSString *)url
                  completion:(void (^)(BOOL, NSArray *))completionHandler
{
    [self loadURLAndParse:[NSURL URLWithString:url]
               completion:completionHandler];
}

@end
