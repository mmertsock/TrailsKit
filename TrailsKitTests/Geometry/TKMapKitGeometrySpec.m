#import <Kiwi/Kiwi.h>
#import "TrailsKit.h"
#import "TKKiwiExtensions.h"

SPEC_BEGIN(TKMapKitGeometrySpec)

describe(@"TKMapKitGeometry", ^{
    context(@"when constructing a region from coordinates", ^{
        it(@"should return a 'zero' region for an empty array", ^{
            MKCoordinateRegion region = MKCoordinateRegionFromCoordinates(@[]);
            [[theValue(MKCoordinateRegionIsZero(region)) should] beTrue];
        });
        it(@"should return a single point for a one-element array", ^{
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(10, 20);
            MKCoordinateRegion region = MKCoordinateRegionFromCoordinates(@[[NSValue valueWithMKCoordinate:coord]]);
            [[@(region.center.latitude) should] equal:coord.latitude withDelta:0.01];
            [[@(region.center.longitude) should] equal:coord.longitude withDelta:0.01];
            [[@(region.span.latitudeDelta) should] equal:0 withDelta:0.01];
            [[@(region.span.longitudeDelta) should] equal:0 withDelta:0.01];
        });
        it(@"should return a rectangle that is the union of all coordinates", ^{
            CLLocationCoordinate2D coord1 = CLLocationCoordinate2DMake(-10, 20);
            CLLocationCoordinate2D coord2 = CLLocationCoordinate2DMake(30, 45);
            CLLocationCoordinate2D coord3 = CLLocationCoordinate2DMake(30, -6);
            NSArray* coords = @[[NSValue valueWithMKCoordinate:coord1], [NSValue valueWithMKCoordinate:coord2], [NSValue valueWithMKCoordinate:coord3]];
            MKCoordinateRegion region = MKCoordinateRegionFromCoordinates(coords);
            // Based on latitude range -10 to 30, and longitude range -6 to 45
            TKExpectLatitudeLongitude(region.center, 10, 19.5);
            [[@(region.span.latitudeDelta) should] equal:40 withDelta:0.01];
            [[@(region.span.longitudeDelta) should] equal:51 withDelta:0.01];
        });
    });
    context(@"when constructing a map rect from a region", ^{
        it(@"should be equivalent to the original region", ^{
            MKCoordinateRegion r1 = (MKCoordinateRegion) {
                .center = CLLocationCoordinate2DMake(42, -77),
                .span = MKCoordinateSpanMake(0.025, 1)
            };
            MKMapRect rect = TKMKMapRectFromCoordinateRegion(r1);
            [[theValue(MKMapRectIsNull(rect)) should] beFalse];
            
            MKCoordinateRegion r2 = MKCoordinateRegionForMapRect(rect);
            TKExpectCoordinate(r2.center, r1.center);
            [[@(r2.span.latitudeDelta) should] equal:r1.span.latitudeDelta withDelta:0.001];
            [[@(r2.span.longitudeDelta) should] equal:r1.span.longitudeDelta withDelta:0.001];
        });
    });
});

SPEC_END
