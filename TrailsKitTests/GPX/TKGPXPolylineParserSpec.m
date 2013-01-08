//
//  TKGPXPolylineParserSpec.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/7/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <MapKit/MapKit.h>
#import "TKGPXPolylineParser.h"
#import "TKStyledPolyline.h"
#import "TKShapeStyle.h"

#define loadData(fileName) [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:[self class]] URLForResource:fileName withExtension:@"gpx"]];

SPEC_BEGIN(TKGPXPolylineParserSpec)

describe(@"TKGPXPolylineParser", ^{

    __block TKGPXPolylineParser* SUT;
    __block NSData* dataToParse;
    
    beforeEach(^{
        SUT = [TKGPXPolylineParser new];
        SUT.shapeStyle = [TKShapeStyle new];
    });
    
	context(@"when parsing a valid GPX file with one track and one segment", ^{
        __block BOOL gotSuccess;
        __block NSArray* gotPolylines;
        beforeEach(^{
            gotSuccess = NO;
            gotPolylines = nil;
            //NSURL* url = [[NSBundle bundleForClass:[self class]] URLForResource:@"test_one_track" withExtension:@"gpx"];
            //dataToParse = [NSData dataWithContentsOfURL:url];
            dataToParse = loadData(@"test_one_track");
            [SUT parseData:dataToParse
                completion:^(BOOL success, NSArray *polylines) {
                    gotSuccess = success;
                    gotPolylines = polylines;
                }];
        });
        it(@"should invoke the callback with the right data", ^{
            [[expectFutureValue(theValue(gotSuccess)) shouldEventually] beTrue];
            [[expectFutureValue(gotPolylines) shouldEventually] haveCountOf:1];
        });
        it(@"should set the style for the parsed polyline", ^{
            [[expectFutureValue(gotPolylines[0]) shouldEventually] beKindOfClass:[TKStyledPolyline class]];
            [[expectFutureValue([gotPolylines[0] shapeStyle]) shouldEventually] beIdenticalTo:SUT.shapeStyle];
        });
    });
    
    context(@"when parsing a bad GPX file", ^{
        __block BOOL gotFailure;
        beforeEach(^{
            // we will check that these get cleared out to NO/nil
            gotFailure = NO;
            dataToParse = loadData(@"test_invalid_gpx");
            [SUT parseData:dataToParse
                completion:^(BOOL success, NSArray *polylines) {
                    gotFailure = !success;
                }];
        });
        it(@"should invoke the callback with a failure", ^{
            [[expectFutureValue(theValue(gotFailure)) shouldEventually] beTrue];
        });
    });
});

SPEC_END