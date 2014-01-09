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
    annotation.visibilityConstraint = [TKVisibilityConstraint constraintWithMaxAltitude:maxAltitude];
    return annotation;
}
@end

SPEC_BEGIN(TKMapObjectManagerSpec)

describe(@"TKMapObjectManager", ^{
	__block TKMapObjectManager *SUT;
    __block MKMapView *mapView;
    __block NSArray *pointsToAdd;
    __block NSArray *overlaysToAdd;
    __block MKMapCamera *mapCamera;
    __block TKPointAnnotation *zoomedInPoint;
    __block TKPointAnnotation *zoomedOutPoint;
    __block TKStyledPolyline *zoomedInOverlay;
    __block TKStyledPolyline *zoomedOutOverlay;
    beforeAll(^{
        mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:CLLocationCoordinate2DMake(0, 0) fromEyeCoordinate:CLLocationCoordinate2DMake(0, 0) eyeAltitude:150000];
        zoomedInPoint = [TKPointAnnotation pointWithLatitude:10 longitude:20 title:@"zoomin" maxAltitude:TKMOMS_ZOOMED_IN + 1];
        zoomedOutPoint = [TKPointAnnotation pointWithLatitude:20 longitude:30 title:@"zoomout" maxAltitude:TKMOMS_ZOOMED_OUT + 1];
        pointsToAdd = @[zoomedInPoint, zoomedOutPoint];
        // nil style == default MKOverlayLevel = Above Roads
        zoomedInOverlay = [[TKStyledPolyline alloc] initWithPolyline:nil style:nil constraint:[TKVisibilityConstraint constraintWithMaxAltitude:TKMOMS_ZOOMED_IN + 1]];
        // level == above labels.
        zoomedOutOverlay = [[TKStyledPolyline alloc] initWithPolyline:nil style:[[TKShapeStyle alloc] initWithStrokeColor:nil lineWidth:0 fillColor:nil overlayLevel:MKOverlayLevelAboveLabels] constraint:[TKVisibilityConstraint constraintWithMaxAltitude:TKMOMS_ZOOMED_OUT + 1]];
        overlaysToAdd = @[zoomedInOverlay, zoomedOutOverlay];
    });
    beforeEach(^{
        mapView = [MKMapView nullMock];
        [mapView stub:@selector(camera) andReturn:mapCamera];
        SUT = [[TKMapObjectManager alloc] initWithMapView:mapView];
    });
    context(@"when initially zoomed out", ^{
        beforeEach(^{
            mapCamera.altitude = TKMOMS_ZOOMED_OUT;
        });
        
        it(@"should only add the annotation allowing zoomed out display to the map view", ^{
            KWCaptureSpy *spy = [(id)mapView captureArgument:@selector(addAnnotations:) atIndex:0];
            [SUT addAnnotations:pointsToAdd];
            NSArray *added = spy.argument;
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
        
        it(@"should only add the overlay allowing zoomed out display to the map view", ^{
            [[[mapView should] receive] addOverlay:zoomedOutOverlay level:MKOverlayLevelAboveLabels];
            [SUT addOverlays:overlaysToAdd];
        });
        it(@"should disallow showing overlays that require zooming in", ^{
            [[theValue([SUT shouldShowOverlay:zoomedInOverlay]) should] beFalse];
            [[theValue([SUT shouldShowOverlay:zoomedOutOverlay]) should] beTrue];
        });
        it(@"should allow showing overlays of unknown type", ^{
            id otherOverlay = [MKPolyline new];
            [[theValue([SUT shouldShowOverlay:otherOverlay]) should] beTrue];
        });
        
        context(@"when zooming in on the map", ^{
            beforeEach(^{
                [SUT addAnnotations:pointsToAdd];
                [SUT addOverlays:overlaysToAdd];
                mapCamera.altitude = TKMOMS_ZOOMED_IN;
            });
            it(@"should show the hidden annotations", ^{
                KWCaptureSpy *spy = [(id)mapView captureArgument:@selector(addAnnotations:) atIndex:0];
                [[mapView should] receive:@selector(addAnnotations:)];
                [SUT mapViewRegionDidChange];
                NSArray *added = spy.argument;
                [[added should] containObjects:zoomedInPoint, nil];
            });
            it(@"should show the hidden overlays at the right level", ^{
                [[[mapView should] receive] addOverlay:zoomedInOverlay level:MKOverlayLevelAboveRoads];
                [SUT mapViewRegionDidChange];
            });
        });
    });
    
	context(@"when initially zoomed in", ^{
        beforeEach(^{
            mapCamera.altitude = TKMOMS_ZOOMED_IN;
        });
        
        it(@"should immediately add all the annotations to the map view", ^{
            [[mapView should] receive:@selector(addAnnotations:)
                        withArguments:pointsToAdd];
            [SUT addAnnotations:pointsToAdd];
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
        
        it(@"should immediately add all the overlays to the map view", ^{
            [[mapView should] receive:@selector(addOverlay:level:) withCount:overlaysToAdd.count];
            [SUT addOverlays:overlaysToAdd];
        });
        
        context(@"when zooming out on the map", ^{
            beforeEach(^{
                [SUT addAnnotations:pointsToAdd];
                [SUT addOverlays:overlaysToAdd];
                [mapView stub:@selector(annotations) andReturn:pointsToAdd];
                [mapView stub:@selector(overlays) andReturn:overlaysToAdd];
                mapCamera.altitude = TKMOMS_ZOOMED_OUT;
            });
            it(@"should remove the annotations from the map that require zooming in", ^{
                KWCaptureSpy *spy = [(id)mapView captureArgument:@selector(removeAnnotations:) atIndex:0];
                [[mapView should] receive:@selector(removeAnnotations:)];
                [SUT mapViewRegionDidChange];
                NSArray *removed = spy.argument;
                [[removed should] containObjects:zoomedInPoint, nil];
            });
            it(@"should remove the overlays from the map that require zooming in", ^{
                KWCaptureSpy *spy = [(id)mapView captureArgument:@selector(removeOverlays:) atIndex:0];
                [[mapView should] receive:@selector(removeOverlays:)];
                [SUT mapViewRegionDidChange];
                [[spy.argument should] containObjects:zoomedInOverlay, nil];
            });
        });
    });
});

SPEC_END
