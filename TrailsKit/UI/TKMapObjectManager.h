//
//  TKMapObjectManager.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/7/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class MKMapView;

@interface TKMapObjectManager : NSObject

@property (nonatomic) CLLocationDistance maxAltitudeForAnnotations;

- (id)initWithMapView:(MKMapView *)mapView;

- (void)addAnnotations:(NSArray *)annotations;

- (void)mapViewRegionDidChange;

@end
