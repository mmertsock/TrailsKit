#import <Kiwi/Kiwi.h>
#import "TKPolyline.h"
#import <MapKit/MapKit.h>
#import "TKKiwiExtensions.h"

SPEC_BEGIN(TKPolylineSpec)

describe(@"TKPolyline", ^{
    __block TKPolyline* SUT;
    context(@"when creating polyline from array of locations", ^{
        __block NSArray* locations;
        context(@"when locations array is empty", ^{
            beforeEach(^{
                SUT = [TKPolyline polylineWithLocations:@[] color:[UIColor brownColor]];
            });
            it(@"should not construct a polyline", ^{
                [SUT shouldBeNil];
            });
        });
        context(@"when locations array is non-empty", ^{
            beforeEach(^{
                locations = @[
                    [[CLLocation alloc] initWithLatitude:0 longitude:0],
                    [[CLLocation alloc] initWithLatitude:0 longitude:2],
                    [[CLLocation alloc] initWithLatitude:2 longitude:0],
                    [[CLLocation alloc] initWithLatitude:2 longitude:2]
                ];
                SUT = [TKPolyline polylineWithLocations:locations color:[UIColor brownColor]];
            });
            it(@"should create a polyline", ^{
                [SUT shouldNotBeNil];
                [[SUT.color should] equal:[UIColor brownColor]];
            });
            it(@"should have a reasonable center point", ^{
                TKExpectLatitudeLongitude(SUT.coordinate, 1, 1);
            });
        });
    });
});

SPEC_END