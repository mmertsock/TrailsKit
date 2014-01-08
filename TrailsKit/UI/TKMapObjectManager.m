//
//  TKMapObjectManager.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/7/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "TKMapObjectManager.h"
#import "TrailsKitGeometry.h"
#import <MapKit/MapKit.h>
#import <NSArray+Functional.h>

@interface TKMapObjectManager () {
    __weak MKMapView *_mapView;
}
@property (nonatomic, readonly) MKMapView *mapView;
@property (nonatomic) NSMutableArray *hiddenAnnotations;
- (BOOL)shouldShowAnnotation:(id<MKAnnotation>)annotation;
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
    NSArray *toShow = [annotations filterUsingBlock:^BOOL(id obj) {
        if ([self shouldShowAnnotation:obj])
            return YES;
        [self.hiddenAnnotations addObject:obj];
        return NO;
    }];
 
    [self.mapView addAnnotations:toShow];
}

- (void)mapViewRegionDidChange
{
    NSArray *annotationsToShow = [self.hiddenAnnotations filterUsingBlock:^BOOL(id obj) {
        return [self shouldShowAnnotation:obj];
    }];
    
    NSArray *annotationsToHide = [self.mapView.annotations filterUsingBlock:^BOOL(id obj) {
        return ![self shouldShowAnnotation:obj];
    }];
    
    if (annotationsToHide.count) {
        [self.mapView removeAnnotations:annotationsToHide];
        [self.hiddenAnnotations addObjectsFromArray:annotationsToHide];
    }
    
    if (annotationsToShow.count) {
        [self.mapView addAnnotations:annotationsToShow];
        [self.hiddenAnnotations removeObjectsInArray:annotationsToShow];
    }
}

- (BOOL)shouldShowAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return YES;
    
    if ([annotation isKindOfClass:[TKPointAnnotation class]]) {
        TKPointAnnotation *pointAnnotation = annotation;
        return ![pointAnnotation.visibilityConstraints shouldHideInMapView:self.mapView];
    }
    
    return YES;
}

@end
