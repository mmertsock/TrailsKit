//
//  TKStyledPolygonArea.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/18/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class TKShapeStyle, TKVisibilityConstraints;

@interface TKStyledPolygonArea : NSObject <MKOverlay>

@property (nonatomic, readonly) MKPolygon* overlay;
@property (nonatomic) TKShapeStyle* shapeStyle;
@property (nonatomic) TKVisibilityConstraints *visibilityConstraints;

+ (instancetype)polygonWithPointsFromPolyline:(MKPolyline*)polyline
                                        style:(TKShapeStyle*)aStyle
                                  constraints:(TKVisibilityConstraints *)visibilityConstraints;

- (id)initWithOverlay:(MKPolygon*)anOverlay
                style:(TKShapeStyle*)aStyle
          constraints:(TKVisibilityConstraints *)visibilityConstraints;

@end
