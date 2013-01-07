//
//  TKPolyline.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/5/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <MapKit/MapKit.h>

@class UIColor;

@interface TKPolyline : NSObject <MKOverlay>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) MKMapRect boundingMapRect;
@property (nonatomic) MKPolyline* polyline;

@property (strong, nonatomic) UIColor* color;

/**
 * Given an NSArray of CLLocation objects.
 */
+ (instancetype)polylineWithLocations:(NSArray*)clLocations
                                color:(UIColor*)color;

- (id)initWithPolyline:(MKPolyline*)polyline
                 color:(UIColor*)color;

@end
