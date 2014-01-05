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
    
    context(@"with no builder for the given reuse identifier", ^{
        it(@"should return no view", ^{
            MKAnnotationView* existingView = [[MKAnnotationView alloc] initWithAnnotation:nil
                                                                          reuseIdentifier:@"testid"];
            [mapView stub:@selector(dequeueReusableAnnotationViewWithIdentifier:) andReturn:existingView];
            result = [SUT mapView:mapView
                viewForAnnotation:annotation
                  reuseIdentifier:@"testid"];
            [result shouldBeNil];
        });
    });
    
    context(@"with a builder for the given reuse identifier", ^{
        __block MKAnnotationView* existingView;
        __block id <TKAnnotationViewBuilder> viewBuilder;
        beforeEach(^{
            viewBuilder = [KWMock nullMockForProtocol:@protocol(TKAnnotationViewBuilder)];
            [SUT setViewBuilder:viewBuilder forReuseIdentifier:@"testid"];
        });
        context(@"when the map view has an annotation available to reuse", ^{
            beforeEach(^{
                existingView = [[MKAnnotationView alloc] initWithAnnotation:nil
                                                            reuseIdentifier:@"testid"];
                [[mapView stubAndReturn:existingView] dequeueReusableAnnotationViewWithIdentifier:@"testid"];
            });
            it(@"should not ask the builder for a new view", ^{
                [[(id)viewBuilder shouldNot] receive:@selector(viewForAnnotation:reuseIdentifier:)];
                [SUT mapView:mapView viewForAnnotation:annotation reuseIdentifier:@"testid"];
            });
            it(@"should ask the builder to configure the existing view", ^{
                [[(id)viewBuilder should] receive:@selector(configureView:withAnnotation:)
                                    withArguments:existingView, annotation];
                [SUT mapView:mapView viewForAnnotation:annotation reuseIdentifier:@"testid"];
            });
            it(@"should return the exsiting view", ^{
                result = [SUT mapView:mapView viewForAnnotation:annotation reuseIdentifier:@"testid"];
                [[result should] beIdenticalTo:existingView];
            });
        });
        
        context(@"when the map does not have an annotation view available to reuse", ^{
            beforeEach(^{
                existingView = [[MKAnnotationView alloc] initWithAnnotation:nil
                                                            reuseIdentifier:@"testid"];
                [[mapView stubAndReturn:nil] dequeueReusableAnnotationViewWithIdentifier:@"testid"];
                [(id)viewBuilder stub:@selector(viewForAnnotation:reuseIdentifier:) andReturn:existingView];
            });
            it(@"should ask the builder for a new view", ^{
                [[(id)viewBuilder should] receive:@selector(viewForAnnotation:reuseIdentifier:)];
                [SUT mapView:mapView viewForAnnotation:annotation reuseIdentifier:@"testid"];
            });
            it(@"should ask the builder to configure the existing view", ^{
                [[(id)viewBuilder should] receive:@selector(configureView:withAnnotation:)
                                    withArguments:existingView, annotation];
                [SUT mapView:mapView viewForAnnotation:annotation reuseIdentifier:@"testid"];
            });
            it(@"should return the new view", ^{
                result = [SUT mapView:mapView viewForAnnotation:annotation reuseIdentifier:@"testid"];
                [[result should] beIdenticalTo:existingView];
            });
        });
    });
    
	context(@"when asking for a view for a point annotation", ^{
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