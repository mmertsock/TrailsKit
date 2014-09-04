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
    __block TKVisibilityContext ctx;
	context(@"given a max-altitude constraint", ^{
        beforeEach(^{
            SUT = [TKVisibilityConstraint constraintWithMaxAltitude:500];
            ctx = (TKVisibilityContext) { .altitude = 0, .scale = 0 };
        });
        specify(^{ [SUT shouldNotBeNil]; });
        it(@"should reject showing in sufficiently zoomed-out maps", ^{
            ctx.altitude = 501;
            [[theValue([SUT shouldHideInContext:ctx]) should] beTrue];
        });
        it(@"should accept showing in sufficiently zoomed-in maps", ^{
            ctx.altitude = 499;
            [[theValue([SUT shouldHideInContext:ctx]) should] beFalse];
        });
    });
});

SPEC_END
