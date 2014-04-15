//
//  TKStyledPolygonAreaSpec.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/19/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <MapKit/MapKit.h>
#import "TrailsKitGeometry.h"

SPEC_BEGIN(TKStyledPolygonAreaSpec)

describe(@"TKStyledPolygonArea", ^{
	__block TKStyledPolygonArea* SUT;
    __block TKShapeStyle* shapeStyle;
    
	context(@"when constructing from a polyline", ^{
        __block MKPolyline* polyline;
        beforeEach(^{
            CLLocationCoordinate2D coords[] = {
                CLLocationCoordinate2DMake(42, -76),
                CLLocationCoordinate2DMake(43, -76),
                CLLocationCoordinate2DMake(44, -77),
                CLLocationCoordinate2DMake(43, -78),
                CLLocationCoordinate2DMake(42, -78)
            };
            polyline = [MKPolyline polylineWithCoordinates:coords count:5];
            shapeStyle = [TKShapeStyle new];
            SUT = [TKStyledPolygonArea polygonWithPointsFromPolyline:polyline
                                                               style:shapeStyle
                                                         constraint:nil];
        });
        specify(^{ [[SUT.shapeStyle should] beIdenticalTo:shapeStyle]; });
        it(@"should construct a polygon overlay with the correct points", ^{
            [[SUT.overlay should] beKindOfClass:[MKPolygon class]];
            [[theValue(SUT.overlay.pointCount) should] equal:theValue(5)];
        });
    });
});

SPEC_END
