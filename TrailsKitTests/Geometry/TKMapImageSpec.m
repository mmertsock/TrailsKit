//
//  TKMapImageSpec.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/4/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "TrailsKitGeometry.h"
#import <UIKit/UIKit.h>

SPEC_BEGIN(TKMapImageSpec)

describe(@"TKMapImage", ^{
	__block TKMapImage* SUT;
    context(@"when making a named image", ^{
        beforeEach(^{
            SUT = [TKMapImage mapImageNamed:@"testimg1"
                               centerOffset:CGPointMake(2, 4)];
        });
        specify(^{ [SUT shouldNotBeNil]; });
        specify(^{ [[theValue(SUT.centerOffset.x) should] equal:2 withDelta:0.1]; });
        specify(^{ [[theValue(SUT.centerOffset.y) should] equal:4 withDelta:0.1]; });
        // Can't easily test the call of +imageNamed: from
        // the TKMapImage property getter, because imageNamed: expects
        // the image to be found in the main bundle.
    });
});

SPEC_END
