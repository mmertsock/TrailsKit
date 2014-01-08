//
//  TKMapObjectManager.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/7/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "TKMapObjectManager.h"
#import <MapKit/MapKit.h>

@interface TKMapObjectManager () {
    __weak MKMapView *_mapView;
}
@property (nonatomic, readonly) MKMapView *mapView;
@property (nonatomic) NSMutableArray *hiddenAnnotations;
- (BOOL)shouldShowAnnotations;
@end

@implementation TKMapObjectManager

- (id)initWithMapView:(MKMapView *)mapView
{
    NSParameterAssert(mapView != nil);
    if (self = [super init]) {
        _mapView = mapView;
        _hiddenAnnotations = [NSMutableArray new];
    }
    return self;
}

- (MKMapView *)mapView
{
    return _mapView;
}

- (void)addAnnotations:(NSArray *)annotations
{
    if ([self shouldShowAnnotations])
        [self.mapView addAnnotations:annotations];
    else
        [self.hiddenAnnotations addObjectsFromArray:annotations];
}

- (void)mapViewRegionDidChange
{
    NSMutableArray *annotationsToHide = [NSMutableArray new];
    NSMutableArray *annotationsToShow = [NSMutableArray new];
    
    if ([self shouldShowAnnotations]) {
        [annotationsToShow addObjectsFromArray:self.hiddenAnnotations];
    } else {
        [annotationsToHide addObjectsFromArray:self.mapView.annotations];
    }
    
    if (annotationsToHide.count) {
        [self.mapView removeAnnotations:annotationsToHide];
        [self.hiddenAnnotations addObjectsFromArray:annotationsToHide];
    }
    
    if (annotationsToShow.count) {
        [self.mapView addAnnotations:annotationsToShow];
        [self.hiddenAnnotations removeObjectsInArray:annotationsToShow];
    }
}

- (BOOL)shouldShowAnnotations
{
    return self.mapView.camera.altitude < self.maxAltitudeForAnnotations;
}

@end
