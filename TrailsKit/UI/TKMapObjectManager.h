//
//  TKMapObjectManager.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/7/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "TrailsKitGeometry.h"

@class MKMapView;
@protocol MKAnnotation, MKOverlay;

@interface TKMapObjectManager : NSObject

- (id)initWithMapView:(MKMapView *)mapView;

@property (nonatomic, readonly) NSSet *visibleAnnotations;

@property (nonatomic, readonly) NSArray *visibleOverlays;

- (void)addAnnotations:(NSArray *)annotations;

- (void)addOverlays:(NSArray *)overlays;

- (void)clearAllObjects;

- (void)mapViewRegionDidChange;
- (void)willZoomMapToVisibility:(TKVisibilityContext)newContext;

- (void)reloadAnnotation:(id <MKAnnotation>)annotation;

- (void)reloadOverlay:(id <MKOverlay>)overlay
              atLevel:(MKOverlayLevel)level;

- (BOOL)shouldShowAnnotation:(id<MKAnnotation>)annotation;
- (BOOL)shouldShowOverlay:(id<MKOverlay>)overlay;

@end
