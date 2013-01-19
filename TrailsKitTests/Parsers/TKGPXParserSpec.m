//
//  TKGPXPolylineParserSpec.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/7/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <MapKit/MapKit.h>
#import "TrailsKitParsers.h"
#import "TrailsKitGeometry.h"

#define loadData(fileName) [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:[self class]] URLForResource:fileName withExtension:@"gpx"]];

SPEC_BEGIN(TKGPXParserSpec)

describe(@"TKGPXParser", ^{

    __block TKGPXParser* SUT;
    __block id<TKGPXOverlayMapper> mapper;
    __block id mapperAsObject;
    
    beforeEach(^{
        mapperAsObject = mapper = [KWMock mockForProtocol:@protocol(TKGPXOverlayMapper)];
        SUT = [[TKGPXParser alloc] initWithMapper:mapper];
    });
    
    context(@"when parsing a GPX file", ^{
        
        __block NSString* dataFileName;
        __block BOOL gotSuccess;
        __block BOOL gotFailure;
        __block NSArray* gotOverlays;
        __block void(^doMapping)(NSString*,NSArray*);
        
        beforeEach(^{
            gotSuccess = gotFailure = NO;
            gotOverlays = nil;
            doMapping = ^(NSString* fileName, NSArray* overlaysToReturn) {
                [mapperAsObject stub:@selector(mapOverlaysFromGPX:)
                           andReturn:overlaysToReturn];
                NSData* dataToParse = loadData(fileName);
                [SUT parseData:dataToParse completion:^(BOOL success, NSArray *overlays) {
                    if (success) gotSuccess = YES; else gotFailure = YES;
                    gotOverlays = overlays;
                }];
            };
        });
    
        context(@"when the GPX file is valid", ^{
            beforeEach(^{ dataFileName = @"test_one_track"; });
            
            context(@"when the mapper returns overlays", ^{
                beforeEach(^{
                    doMapping(dataFileName, @[[TKStyledPolyline new], [TKStyledPolyline new]]);
                });
                it(@"should invoke the callback indicating success", ^{
                    [[expectFutureValue(theValue(gotSuccess)) shouldEventually] beTrue];
                });
                it(@"should invoke the callback with the right data", ^{
                    [[expectFutureValue(gotOverlays) shouldEventually] haveCountOf:2];
                });
            });
            
            context(@"when the mapper returns zero overlays", ^{
                beforeEach(^{ doMapping(dataFileName, @[]); });
                it(@"should invoke the callback indicating success", ^{
                    [[expectFutureValue(theValue(gotSuccess)) shouldEventually] beTrue];
                });
                it(@"should invoke the callback with an empty set of overlays", ^{
                    [[expectFutureValue(gotOverlays) shouldEventually] beEmpty];
                });
            });
            
            context(@"when the mapper returns nil", ^{
                beforeEach(^{ doMapping(dataFileName, nil); });
                it(@"should invoke the callback indicating failure", ^{
                    [[expectFutureValue(theValue(gotFailure)) shouldEventually] beTrue];
                });
            });
        });
        
        context(@"when the GPX file is invalid", ^{
            beforeEach(^{ doMapping(@"test_invalid_gpx", @[]); });
            it(@"should invoke the callback indicating failure", ^{
                [[expectFutureValue(theValue(gotFailure)) shouldEventually] beTrue];
            });
        });
        
    });
    
});

SPEC_END