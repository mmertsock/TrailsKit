//
//  TKMapObjectManagerSpec.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/7/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <MapKit/MapKit.h>
#import "TKMapObjectManager.h"
#import "TrailsKitGeometry.h"

SPEC_BEGIN(TKMapObjectManagerSpec)

describe(@"TKMapObjectManager", ^{
	__block TKMapObjectManager *SUT;
    __block MKMapView *mapView;
    __block NSArray *objectsToAdd;
    beforeEach(^{
        mapView = [MKMapView nullMock];
        SUT = [[TKMapObjectManager alloc] initWithMapView:mapView];
        objectsToAdd = nil;
    });
	context(@"when adding annotations", ^{
        beforeEach(^{
            objectsToAdd = @[
             [[TKPointAnnotation alloc] initWithLatitude:10 longitude:20 title:@"first"],
             [[TKPointAnnotation alloc] initWithLatitude:20 longitude:30 title:@"second"]
             ];
        });
        it(@"it should immediately add all the annotations to the map view", ^{
            [[mapView should] receive:@selector(addAnnotations:)
                        withArguments:objectsToAdd];
            [SUT addAnnotations:objectsToAdd];
        });
    });
});

SPEC_END
