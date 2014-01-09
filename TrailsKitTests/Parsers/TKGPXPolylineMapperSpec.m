//
//  TKGPXPolylineMapperSpec.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/19/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "TrailsKitGeometry.h"
#import "TrailsKitParsers.h"
#import <GPXParser/GPXParser.h>
#import <MapKit/MapKit.h>

SPEC_BEGIN(TKGPXPolylineMapperSpec)

describe(@"TKGPXPolylineMapper", ^{
    __block TKShapeStyle* shapeStyle;
	__block TKGPXPolylineMapper* SUT;
    __block GPX* gpx;
    __block NSArray* result;
    
    beforeEach(^{
        shapeStyle = [TKShapeStyle new];
        id constraint = [TKVisibilityConstraint constraintWithMaxAltitude:1000];
        SUT = [[TKGPXPolylineMapper alloc] initWithStyle:shapeStyle defaultVisibilityConstraint:constraint];
        gpx = [GPX new];
    });
    
    context(@"when initializing the mapper", ^{
        it(@"should have the correct style", ^{
            [[SUT.shapeStyle should] beIdenticalTo:shapeStyle];
        });
    });
    
	context(@"when mapping GPX with one track", ^{
        beforeEach(^{
            Track* track = [Track new];
            track.path = [KWMock mockForProtocol:@protocol(MKOverlay)];
            [gpx.tracks addObject:track];
            result = [SUT mapOverlaysFromGPX:gpx];
        });
        specify(^{ [[result should] haveCountOf:1]; });
        it(@"should return a correct Polyline overlay in the array", ^{
            if (result.count < 1) return;
            [[result[0] should] beKindOfClass:[TKStyledPolyline class]];
            TKStyledPolyline* polyline = result[0];
            [[polyline.shapeStyle should] beIdenticalTo:shapeStyle];
            [[polyline.visibilityConstraint should] beIdenticalTo:SUT.defaultVisibilityConstraint];
            [[(id)polyline.overlay should] beIdenticalTo:[gpx.tracks[0] path]];
        });
    });
    
    context(@"when mapping GPX with multiple tracks", ^{
        beforeEach(^{
            Track* track = [Track new];
            track.path = [KWMock mockForProtocol:@protocol(MKOverlay)];
            [gpx.tracks addObject:track];
            track = [Track new];
            track.path = [KWMock mockForProtocol:@protocol(MKOverlay)];
            [gpx.tracks addObject:track];
            result = [SUT mapOverlaysFromGPX:gpx];
        });
        specify(^{ [[result should] haveCountOf:2]; });
    });
    
    context(@"when mapping GPX with no tracks", ^{
        beforeEach(^{ result = [SUT mapOverlaysFromGPX:gpx]; });
        specify(^{ [[result should] beEmpty]; });
    });
});

SPEC_END
