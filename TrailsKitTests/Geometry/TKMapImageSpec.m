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
	context(@"when making a map image with imageName", ^{
        beforeEach(^{
            SUT = [TKMapImage mapImageNamed:@""];
        });
        specify(^{ [SUT shouldNotBeNil]; });
    });
});

SPEC_END
