#import <Kiwi/Kiwi.h>
#import "NSArray+MapKitGeometry.h"
#import "TrailsKitGeometry.h"
#import "TKKiwiExtensions.h"

SPEC_BEGIN(NSArrayMapKitGeometrySpec)

describe(@"NSArrayMapKitGeometry", ^{
    __block NSArray* input;
    
    context(@"when getting coordinates of annotations", ^{
        __block NSArray* result;
        context(@"when annotations are empty", ^{
            beforeEach(^{ result = [@[] tk_coordinatesOfAnnotations]; });
            it(@"should return an empty array", ^{ [[result should] beEmpty]; });
        });
        context(@"when mapping many annotations", ^{
            beforeEach(^{ input = @[
                [[TKPointAnnotation alloc] initWithLatitude:0 longitude:1 title:@"a"],
                [[TKPointAnnotation alloc] initWithLatitude:2 longitude:0 title:@"b"],
                [[TKPointAnnotation alloc] initWithLatitude:0 longitude:3 title:@"c"]
                ];
                result = [input tk_coordinatesOfAnnotations];
            });
            it(@"should return a single coordinate", ^{
                [[result should] haveCountOf:3];
                [[result[0] should] beKindOfClass:[NSValue class]];
                TKExpectLatitudeLongitude([result[0] MKCoordinateValue], 0, 1);
                TKExpectLatitudeLongitude([result[1] MKCoordinateValue], 2, 0);
                TKExpectLatitudeLongitude([result[2] MKCoordinateValue], 0, 3);
            });
        });
    });
    
    context(@"when getting a C array of coordinates", ^{
        //__block BOOL blockCalled;
        //beforeEach(^{ blockCalled = NO; });
        context(@"when the input array is empty", ^{
            beforeEach(^{ input = @[]; });
            it(@"should return NULL", ^{
                CLLocationCoordinate2D* result = [input tk_CArrayOfLocationCoordinates];
                [[theValue(result == NULL) should] beTrue];
                if (result) free(result);
                /*
                [input getCArrayOfLocationCoordinatesForBlock:^(CLLocationCoordinate2D *result, NSUInteger count) {
                    [[@(count) should] equal:@(0)];
                    blockCalled = YES;
                }];
                [[@(blockCalled) should] beTrue];
                //*/
            });
        });
        context(@"when the input array has many locations", ^{
            beforeEach(^{
                input = @[
                    [[CLLocation alloc] initWithLatitude:0 longitude:1],
                    [[CLLocation alloc] initWithLatitude:2 longitude:0],
                    [[CLLocation alloc] initWithLatitude:0 longitude:3]
                ];
            });
            it(@"should return a C array with each coordinate", ^{
                CLLocationCoordinate2D* result = [input tk_CArrayOfLocationCoordinates];
                [[theValue(result == NULL) should] beFalse];
                if (result)
                {
                    TKExpectLatitudeLongitude(result[0], 0, 1);
                    TKExpectLatitudeLongitude(result[1], 2, 0);
                    TKExpectLatitudeLongitude(result[2], 0, 3);
                    free(result);
                }

                /*
                [input getCArrayOfLocationCoordinatesForBlock:^(CLLocationCoordinate2D *result, NSUInteger count) {
                    [[@(count) should] equal:@(3)];
                    [[theValue(result == NULL) should] beFalse];
                    if (result) {
                        TKExpectLatitudeLongitude(result[0], 0, 1);
                        TKExpectLatitudeLongitude(result[1], 2, 0);
                        TKExpectLatitudeLongitude(result[2], 0, 3);
                    }
                    blockCalled = YES;
                }];
                [[@(blockCalled) should] beTrue];
                 //*/
            });
        });
    });
    
});

SPEC_END
