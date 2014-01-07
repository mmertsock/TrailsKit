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
@end

@implementation TKMapObjectManager

- (id)initWithMapView:(MKMapView *)mapView
{
    NSParameterAssert(mapView != nil);
    if (self = [super init]) {
        _mapView = mapView;
    }
    return self;
}

- (MKMapView *)mapView
{
    return _mapView;
}

- (void)addAnnotations:(NSArray *)annotations
{
    [self.mapView addAnnotations:annotations];
}

@end
