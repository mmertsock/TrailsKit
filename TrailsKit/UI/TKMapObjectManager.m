//
//  TKMapObjectManager.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/7/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "TKMapObjectManager.h"
#import "TrailsKitGeometry.h"
#import "MKMapView+TrailsKit.h"
#import <MapKit/MapKit.h>
#import <NSArray+Functional.h>

@interface TKMapObjectManager () {
    __weak MKMapView *_mapView;
}
@property (nonatomic, readonly) MKMapView *mapView;
@property (nonatomic) NSMutableArray *hiddenAnnotations;
@property (nonatomic) NSMutableArray *hiddenOverlays;
- (void)addOverlaysToMapView:(NSArray *)overlays;
- (void)prepareForVisibilityContext:(TKVisibilityContext)newContext
                           hideOnly:(BOOL)hideOnly;
- (BOOL)shouldShowAnnotation:(id<MKAnnotation>)annotation
                   inContext:(TKVisibilityContext)context;
- (BOOL)shouldShowOverlay:(id<MKOverlay>)overlay
                inContext:(TKVisibilityContext)context;
@end

@implementation TKMapObjectManager

- (id)initWithMapView:(MKMapView *)mapView
{
    NSParameterAssert(mapView != nil);
    if (self = [super init]) {
        _mapView = mapView;
        _hiddenAnnotations = [NSMutableArray new];
        _hiddenOverlays = [NSMutableArray new];
    }
    return self;
}

- (MKMapView *)mapView
{
    return _mapView;
}

- (void)addAnnotations:(NSArray *)annotations
{
    NSAssert([NSThread isMainThread], @"TKMapObjectManager addAnnotations: must run in main thread");
    TKVisibilityContext context = self.mapView.tk_visibilityContext;
    NSArray *toShow = [annotations filterUsingBlock:^BOOL(id obj) {
        if ([self shouldShowAnnotation:obj inContext:context])
            return YES;
        [self.hiddenAnnotations addObject:obj];
        return NO;
    }];
 
    [self.mapView addAnnotations:toShow];
}

- (void)addOverlays:(NSArray *)overlays
{
    NSAssert([NSThread isMainThread], @"TKMapObjectManager addOverlays: must run in main thread");
    TKVisibilityContext context = self.mapView.tk_visibilityContext;
    NSArray *toShow = [overlays filterUsingBlock:^BOOL(id obj) {
        if ([self shouldShowOverlay:obj inContext:context])
            return YES;
        [self.hiddenOverlays addObject:obj];
        return NO;
    }];
    
    [self addOverlaysToMapView:toShow];
}

- (void)clearAllObjects
{
    NSAssert([NSThread isMainThread], @"TKMapObjectManager clearAllObjects must run in main thread");
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.hiddenAnnotations removeAllObjects];
    [self.hiddenOverlays removeAllObjects];
}

- (void)mapViewRegionDidChange
{
    TKVisibilityContext context = self.mapView.tk_visibilityContext;
    [self prepareForVisibilityContext:context hideOnly:NO];
}

- (void)willZoomMapToVisibility:(TKVisibilityContext)newContext
{
    [self prepareForVisibilityContext:newContext hideOnly:YES];
}

- (void)prepareForVisibilityContext:(TKVisibilityContext)context
                           hideOnly:(BOOL)hideOnly
{
    NSArray *annotationsToShow = hideOnly ? @[] : [self.hiddenAnnotations filterUsingBlock:^BOOL(id obj) {
        return [self shouldShowAnnotation:obj inContext:context];
    }];
    
    NSArray *annotationsToHide = [self.mapView.annotations filterUsingBlock:^BOOL(id obj) {
        return ![self shouldShowAnnotation:obj inContext:context];
    }];
    
    if (annotationsToHide.count) {
        [self.mapView removeAnnotations:annotationsToHide];
        [self.hiddenAnnotations addObjectsFromArray:annotationsToHide];
    }
    
    if (annotationsToShow.count) {
        [self.mapView addAnnotations:annotationsToShow];
        [self.hiddenAnnotations removeObjectsInArray:annotationsToShow];
    }
    
    NSArray *overlaysToShow = hideOnly ? @[] : [self.hiddenOverlays filterUsingBlock:^BOOL(id obj) {
        return [self shouldShowOverlay:obj inContext:context];
    }];
    
    NSArray *overlaysToHide = [self.mapView.overlays filterUsingBlock:^BOOL(id obj) {
        return ![self shouldShowOverlay:obj inContext:context];
    }];
    
    if (overlaysToHide.count) {
        [self.mapView removeOverlays:overlaysToHide];
        [self.hiddenOverlays addObjectsFromArray:overlaysToHide];
    }
    
    if (overlaysToShow.count) {
        [self addOverlaysToMapView:overlaysToShow];
        [self.hiddenOverlays removeObjectsInArray:overlaysToShow];
    }
}

- (void)addOverlaysToMapView:(NSArray *)overlays
{
    for (id <MKOverlay> overlay in overlays) {
        MKOverlayLevel level = MKOverlayLevelAboveRoads;
        if ([overlay respondsToSelector:@selector(shapeStyle)]) {
            level = [(id)overlay shapeStyle].overlayLevel;
        }
        [self.mapView addOverlay:overlay level:level];
    };
}

- (BOOL)shouldShowAnnotation:(id<MKAnnotation>)annotation
{
    return [self shouldShowAnnotation:annotation
                            inContext:self.mapView.tk_visibilityContext];
}

- (BOOL)shouldShowAnnotation:(id<MKAnnotation>)annotation inContext:(TKVisibilityContext)context
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return YES;
    
    if ([annotation conformsToProtocol:@protocol(TKHasVisibilityConstraint)]) {
        TKVisibilityConstraint *constraint = [(id<TKHasVisibilityConstraint>)annotation visibilityConstraint];
        return !constraint || [constraint shouldShowInContext:context];
    }
    
    return YES;
}

- (BOOL)shouldShowOverlay:(id<MKOverlay>)overlay
{
    return [self shouldShowOverlay:overlay
                         inContext:self.mapView.tk_visibilityContext];
}

- (BOOL)shouldShowOverlay:(id<MKOverlay>)overlay
                inContext:(TKVisibilityContext)context
{
    if ([overlay conformsToProtocol:@protocol(TKHasVisibilityConstraint)]) {
        TKVisibilityConstraint *constraint = [(id<TKHasVisibilityConstraint>)overlay visibilityConstraint];
        return !constraint || [constraint shouldShowInContext:context];
    }
    
    return YES;
}

@end
