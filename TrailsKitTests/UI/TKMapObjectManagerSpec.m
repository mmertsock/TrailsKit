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

@interface TKPointAnnotation (WithMaxAltitude)
+ (instancetype)pointWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon title:(NSString *)aTitle maxAltitude:(CLLocationDistance)maxAltitude;
@end

@implementation TKPointAnnotation (WithMaxAltitude)
+ (instancetype)pointWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon title:(NSString *)aTitle maxAltitude:(CLLocationDistance)maxAltitude
{
    TKPointAnnotation *annotation = [[self alloc] initWithLatitude:lat longitude:lon title:aTitle];
    annotation.visibilityConstraints = [TKVisibilityConstraints constraintsWithMaxAltitude:maxAltitude];
    return annotation;
}
@end

SPEC_BEGIN(TKMapObjectManagerSpec)

describe(@"TKMapObjectManager", ^{
	__block TKMapObjectManager *SUT;
    __block MKMapView *mapView;
    __block NSArray *objectsToAdd;
    __block MKMapCamera *mapCamera;
    __block KWCaptureSpy *addAnnotationsSpy;
    __block KWCaptureSpy *remAnnotationsSpy;
    __block TKPointAnnotation *zoomedInPoint;
    __block TKPointAnnotation *zoomedOutPoint;
    beforeEach(^{
        mapView = [MKMapView nullMock];
        mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:CLLocationCoordinate2DMake(0, 0) fromEyeCoordinate:CLLocationCoordinate2DMake(0, 0) eyeAltitude:150000];
        [mapView stub:@selector(camera) andReturn:mapCamera];
        addAnnotationsSpy = remAnnotationsSpy = nil;
        SUT = [[TKMapObjectManager alloc] initWithMapView:mapView];
        zoomedInPoint = [TKPointAnnotation pointWithLatitude:10 longitude:20 title:@"zoomin" maxAltitude:TKMOMS_ZOOMED_IN + 1];
        zoomedOutPoint = [TKPointAnnotation pointWithLatitude:20 longitude:30 title:@"zoomout" maxAltitude:TKMOMS_ZOOMED_OUT + 1];
        objectsToAdd = @[zoomedInPoint, zoomedOutPoint];
    });
    context(@"when initially zoomed out", ^{
        beforeEach(^{
            mapCamera.altitude = TKMOMS_ZOOMED_OUT;
        });
        it(@"should only add the annotation with allowing zoomed out display to the map view", ^{
            addAnnotationsSpy = [(id)mapView captureArgument:@selector(addAnnotations:) atIndex:0];
            [SUT addAnnotations:objectsToAdd];
            NSArray *added = addAnnotationsSpy.argument;
            [[added should] haveCountOf:1];
            [[added should] containObjects:zoomedOutPoint, nil];
        });
        it(@"should disallow showing annotations that require zooming in", ^{
            [[theValue([SUT shouldShowAnnotation:zoomedInPoint]) should] beFalse];
            [[theValue([SUT shouldShowAnnotation:zoomedOutPoint]) should] beTrue];
        });
        it(@"should allow showing the current user location annotation", ^{
            id userLocation = [[MKUserLocation alloc] init];
            [[theValue([SUT shouldShowAnnotation:userLocation]) should] beTrue];
        });
        it(@"should allow showing annotations of unknown type", ^{
            id otherAnnotation = [[MKPointAnnotation alloc] init];
            [[theValue([SUT shouldShowAnnotation:otherAnnotation]) should] beTrue];
        });
        context(@"when zooming in on the map", ^{
            beforeEach(^{
                [SUT addAnnotations:objectsToAdd];
                mapCamera.altitude = TKMOMS_ZOOMED_IN;
            });
            it(@"should show the hidden annotations", ^{
                addAnnotationsSpy = [(id)mapView captureArgument:@selector(addAnnotations:) atIndex:0];
                [[mapView should] receive:@selector(addAnnotations:)];
                [SUT mapViewRegionDidChange];
                NSArray *added = addAnnotationsSpy.argument;
                [[added should] containObjects:zoomedInPoint, nil];
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
        it(@"should allow showing annotations that require zooming in", ^{
            [[theValue([SUT shouldShowAnnotation:zoomedInPoint]) should] beTrue];
            [[theValue([SUT shouldShowAnnotation:zoomedOutPoint]) should] beTrue];
        });
        it(@"should allow showing the current user location annotation", ^{
            id userLocation = [[MKUserLocation alloc] init];
            [[theValue([SUT shouldShowAnnotation:userLocation]) should] beTrue];
        });
        it(@"should allow showing annotations of unknown type", ^{
            id otherAnnotation = [[MKPointAnnotation alloc] init];
            [[theValue([SUT shouldShowAnnotation:otherAnnotation]) should] beTrue];
        });
        context(@"when zooming out on the map", ^{
            beforeEach(^{
                [SUT addAnnotations:objectsToAdd];
                [mapView stub:@selector(annotations) andReturn:objectsToAdd];
                mapCamera.altitude = TKMOMS_ZOOMED_OUT;
            });
            it(@"should remove the annotations from the map that require zooming in", ^{
                remAnnotationsSpy = [(id)mapView captureArgument:@selector(removeAnnotations:) atIndex:0];
                [[mapView should] receive:@selector(removeAnnotations:)];
                [SUT mapViewRegionDidChange];
                NSArray *removed = remAnnotationsSpy.argument;
                [[removed should] containObjects:zoomedInPoint, nil];
            });
        });
    });
});

SPEC_END
