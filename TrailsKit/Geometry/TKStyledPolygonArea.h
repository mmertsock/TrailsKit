//
//  TKStyledPolygonArea.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/18/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TKMapKitGeometry.h"

@class TKShapeStyle, TKVisibilityConstraint;

@interface TKStyledPolygonArea : NSObject <MKOverlay, TKHasVisibilityConstraint>

@property (nonatomic, readonly) MKPolygon* overlay;
@property (nonatomic) TKShapeStyle* shapeStyle;
@property (nonatomic) TKVisibilityConstraint *visibilityConstraint;
@property (strong, nonatomic) id data;

+ (instancetype)polygonWithPointsFromPolyline:(MKPolyline*)polyline
                                        style:(TKShapeStyle*)aStyle
                                   constraint:(TKVisibilityConstraint *)visibilityConstraint;

- (id)initWithOverlay:(MKPolygon*)anOverlay
                style:(TKShapeStyle*)aStyle
           constraint:(TKVisibilityConstraint *)visibilityConstraint;

- (id)initWithOverlay:(MKPolygon*)anOverlay
                style:(TKShapeStyle*)aStyle
           constraint:(TKVisibilityConstraint *)visibilityConstraint
                 data:(id)data;

@end
