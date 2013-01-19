//
//  TKGPXPolygonMapperSpec.m
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

@interface MKPolyline (TestPolylineBuilder)
+ (MKPolyline*)polylineForTesting;
@end
@implementation MKPolyline (TestPolylineBuilder)
+ (MKPolyline*)polylineForTesting
{
    CLLocationCoordinate2D coords[3] = {
        CLLocationCoordinate2DMake(42, -76),
        CLLocationCoordinate2DMake(43, -76),
        CLLocationCoordinate2DMake(42, -77)
    };
    return [MKPolyline polylineWithCoordinates:coords count:3];
}
@end

SPEC_BEGIN(TKGPXPolygonMapperSpec)

describe(@"TKGPXPolygonMapper", ^{
    __block TKShapeStyle* shapeStyle;
	__block TKGPXPolygonMapper* SUT;
    __block GPX* gpx;
    __block NSArray* result;
    
    beforeEach(^{
        shapeStyle = [TKShapeStyle new];
        SUT = [[TKGPXPolygonMapper alloc] initWithStyle:shapeStyle];
        gpx = [GPX new];
    });
    
	context(@"when initializing the mapper", ^{
        it(@"should have the correct style", ^{
            [[SUT.shapeStyle should] beIdenticalTo:shapeStyle];
        });
    });
    
    context(@"when mapping GPX with one track", ^{
        __block TKStyledPolygonArea* polygonResult;
        beforeEach(^{
            Track* track = [Track new];
            track.path = [MKPolyline polylineForTesting];
            [gpx.tracks addObject:track];
            result = [SUT mapOverlaysFromGPX:gpx];
            if (result.count && [result[0] isKindOfClass:[TKStyledPolygonArea class]])
                polygonResult = result[0];
        });
        specify(^{ [[result should] haveCountOf:1]; });
        specify(^{ [polygonResult shouldNotBeNil]; });
        it(@"should return a correctly styled Polygon overlay", ^{
            [[polygonResult.shapeStyle should] beIdenticalTo:shapeStyle];
        });
        it(@"should return a polygon with the right points", ^{
            [[(id)polygonResult.overlay should] beKindOfClass:[MKPolygon class]];
            [[theValue(polygonResult.overlay.pointCount) should] equal:theValue(3)];
        });
    });
    
    context(@"when mapping GPX with multiple tracks", ^{
        beforeEach(^{
            Track* track = [Track new];
            track.path = [MKPolyline polylineForTesting];
            [gpx.tracks addObject:track];
            track = [Track new];
            track.path = [MKPolyline polylineForTesting];
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