//
//  TKStyledPolyline.h
//  GPXTest
//
//  Created by Mike Mertsock on 1/6/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class TKShapeStyle, TKVisibilityConstraints;

@interface TKStyledPolyline : NSObject <MKOverlay>

@property (nonatomic, readonly) id<MKOverlay> overlay;
@property (nonatomic) TKShapeStyle* shapeStyle;
@property (nonatomic) TKVisibilityConstraints *visibilityConstraints;

- (id)initWithPolyline:(id<MKOverlay>)polyline
                 style:(TKShapeStyle*)aStyle
           constraints:(TKVisibilityConstraints *)visibilityConstraints;

@end
