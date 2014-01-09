//
//  TKVisibilityConstraintSpec.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/8/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "TrailsKitGeometry.h"
#import <MapKit/MapKit.h>

SPEC_BEGIN(TKVisibilityConstraintSpec)

describe(@"TKVisibilityConstraint", ^{
	__block TKVisibilityConstraint *SUT;
    __block MKMapView *mapView;
    __block MKMapCamera *mapCamera;
	context(@"given a max-altitude constraint", ^{
        beforeEach(^{
            SUT = [TKVisibilityConstraint constraintWithMaxAltitude:500];
            mapView = [MKMapView nullMock];
            mapCamera = [MKMapCamera camera];
            [mapView stub:@selector(camera) andReturn:mapCamera];
        });
        specify(^{ [SUT shouldNotBeNil]; });
        it(@"should reject showing in sufficiently zoomed-out maps", ^{
            mapCamera.altitude = 501;
            [[theValue([SUT shouldHideInMapView:mapView]) should] beTrue];
        });
        it(@"should accept showing in sufficiently zoomed-in maps", ^{
            mapCamera.altitude = 499;
            [[theValue([SUT shouldHideInMapView:mapView]) should] beFalse];
        });
    });
});

SPEC_END
