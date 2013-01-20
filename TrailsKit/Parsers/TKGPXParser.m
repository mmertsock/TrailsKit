//
//  TKGPXParser.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/18/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKGPXParser.h"
#import "TKGPXOverlayMapper.h"
#import <GPXParser/GPXParser.h>

@implementation TKGPXParser

- (id)initWithMapper:(id<TKGPXOverlayMapper>)aMapper
{
    if (self = [super init]) {
        _mapper = aMapper;
    }
    return self;
}

- (void)parseData:(NSData*)gpxData
       completion:(TKOverlayCompletionHandler)completionHandler
{
    [GPXParser parse:gpxData completion:^(BOOL success, GPX *gpx) {
        NSArray* polylines = success ? [self.mapper mapOverlaysFromGPX:gpx] : nil;
        completionHandler(polylines != nil, polylines);
    }];
}

@end
