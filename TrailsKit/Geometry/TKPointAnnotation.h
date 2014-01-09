//
//  TKPointAnnotation.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/2/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TKMapKitGeometry.h"

@class TKShapeStyle, TKVisibilityConstraint;

@interface TKPointAnnotation : MKPointAnnotation <TKHasVisibilityConstraint>

@property (strong, nonatomic) id data;
@property (strong, nonatomic) TKShapeStyle *style;
@property (strong, nonatomic) TKVisibilityConstraint *visibilityConstraint;

- (id)initWithLatitude:(CLLocationDegrees)lat
             longitude:(CLLocationDegrees)lon
                 title:(NSString*)aTitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coords
                   title:(NSString*)aTitle
                    data:(id)data
                   style:(TKShapeStyle *)style
              constraint:(TKVisibilityConstraint *)visibilityConstraint;

@end
