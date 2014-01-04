//
//  TKAnnotationViewFactorySpec.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/27/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "TrailsKitGeometry.h"
#import "TrailsKitUI.h"
#import <MapKit/MapKit.h>

SPEC_BEGIN(TKAnnotationViewFactorySpec)

describe(@"TKAnnotationViewFactory", ^{
    
	__block TKAnnotationViewFactory* SUT;
    __block MKMapView* mapView;
    __block MKAnnotationView* result;
    __block TKPointAnnotation* annotation;
    __block BOOL newViewBlockCalled;
    
    beforeEach(^{
        newViewBlockCalled = NO;
        SUT = [TKAnnotationViewFactory new];
        mapView = [MKMapView mock];
        annotation = [[TKPointAnnotation alloc] initWithLatitude:42
                                                       longitude:-77
                                                           title:@"test-title"];
    });
    
	context(@"when asking for a view for a pin annotation", ^{
        context(@"when the map view has an existing view available to dequeue", ^{
            __block MKAnnotationView* existingView;
            beforeEach(^{
                existingView = [[MKAnnotationView alloc] initWithAnnotation:nil
                                                            reuseIdentifier:@"testid"];
                [mapView stub:@selector(dequeueReusableAnnotationViewWithIdentifier:) andReturn:existingView];
                result = [SUT reusableViewForAnnotation:annotation
                                         withIdentifier:@"testid"
                                             forMapView:mapView
                                           newViewBlock:^(MKAnnotationView* view) {
                                               newViewBlockCalled = YES;
                                           }];
            });
            it(@"should return the existing annotation view", ^{
                [[result should] beIdenticalTo:existingView];
            });
            it(@"should update the annotation in the view", ^{
                [[(id)result.annotation should] beIdenticalTo:annotation];
            });
            it(@"should not invoke the block for configuring new views", ^{
                [[theValue(newViewBlockCalled) should] beFalse];
            });
        });
        
        context(@"when the map view does not have a view available to dequeue", ^{
            beforeEach(^{
                [mapView stub:@selector(dequeueReusableAnnotationViewWithIdentifier:) andReturn:nil];
                result = [SUT reusableViewForAnnotation:annotation
                                         withIdentifier:@"testid"
                                             forMapView:mapView
                                           newViewBlock:^(MKAnnotationView* view) {
                                               newViewBlockCalled = YES;
                                           }];
            });
            it(@"should create a new annotation view", ^{
                [result shouldNotBeNil];
                [[result.reuseIdentifier should] equal:@"testid"];
            });
            it(@"should set the annotation in the view", ^{
                [[(id)result.annotation should] beIdenticalTo:annotation];
            });
            it(@"should invoke the block for configuring new views", ^{
                [[theValue(newViewBlockCalled) should] beTrue];
            });
        });
    });
});

SPEC_END