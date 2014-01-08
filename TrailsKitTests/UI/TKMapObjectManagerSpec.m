//
//  TKMapObjectManagerSpec.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/7/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <MapKit/MapKit.h>
#import "TKMapObjectManager.h"
#import "TrailsKitGeometry.h"

static const CLLocationDistance TKMOMS_ZOOMED_OUT = 200000;
static const CLLocationDistance TKMOMS_ZOOMED_IN = 1000;

SPEC_BEGIN(TKMapObjectManagerSpec)

describe(@"TKMapObjectManager", ^{
	__block TKMapObjectManager *SUT;
    __block MKMapView *mapView;
    __block NSArray *objectsToAdd;
    __block MKMapCamera *mapCamera;
    __block KWCaptureSpy *addAnnotationsSpy;
    __block KWCaptureSpy *remAnnotationsSpy;
    beforeEach(^{
        mapView = [MKMapView nullMock];
        mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:CLLocationCoordinate2DMake(0, 0) fromEyeCoordinate:CLLocationCoordinate2DMake(0, 0) eyeAltitude:150000];
        [mapView stub:@selector(camera) andReturn:mapCamera];
        addAnnotationsSpy = [(id)mapView captureArgument:@selector(addAnnotations:) atIndex:0];
        remAnnotationsSpy = [(id)mapView captureArgument:@selector(removeAnnotations:) atIndex:0];
        SUT = [[TKMapObjectManager alloc] initWithMapView:mapView];
        SUT.maxAltitudeForAnnotations = TKMOMS_ZOOMED_IN + 1;
        objectsToAdd = @[
                         [[TKPointAnnotation alloc] initWithLatitude:10 longitude:20 title:@"first"],
                         [[TKPointAnnotation alloc] initWithLatitude:20 longitude:30 title:@"second"]
                         ];
    });
    context(@"when initially zoomed out", ^{
        beforeEach(^{
            mapCamera.altitude = TKMOMS_ZOOMED_OUT;
        });
        it(@"should not immediately add all the annotations to the map view", ^{
            [[mapView shouldNot] receive:@selector(addAnnotations:)
                           withArguments:objectsToAdd];
            [SUT addAnnotations:objectsToAdd];
        });
        context(@"when zooming in on the map", ^{
            beforeEach(^{
                [SUT addAnnotations:objectsToAdd];
                mapCamera.altitude = TKMOMS_ZOOMED_IN;
            });
            it(@"should show the hidden annotations", ^{
                [[mapView should] receive:@selector(addAnnotations:)];
                [SUT mapViewRegionDidChange];
                NSArray *added = addAnnotationsSpy.argument;
                [[added should] containObjects:objectsToAdd[0], objectsToAdd[1], nil];
            });
        });
    });
    
	context(@"when initially zoomed in", ^{
        beforeEach(^{
            mapCamera.altitude = TKMOMS_ZOOMED_IN;
        });
        it(@"should immediately add all the annotations to the map view", ^{
            [[mapView should] receive:@selector(addAnnotations:)
                        withArguments:objectsToAdd];
            [SUT addAnnotations:objectsToAdd];
        });
        context(@"when zooming out on the map", ^{
            beforeEach(^{
                [SUT addAnnotations:objectsToAdd];
                [mapView stub:@selector(annotations) andReturn:objectsToAdd];
                mapCamera.altitude = TKMOMS_ZOOMED_OUT;
            });
            it(@"should remove the annotations from the map", ^{
                [[mapView should] receive:@selector(removeAnnotations:)];
                [SUT mapViewRegionDidChange];
                NSArray *removed = remAnnotationsSpy.argument;
                [[removed should] containObjects:objectsToAdd[0], objectsToAdd[1], nil];
            });
        });
    });
});

SPEC_END
