//
//  TKStyledPolylineView.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/9/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKStyledPolyline, TKStyledPolygonArea, MKOverlayView;

@interface TKStyledPolylineViewFactory : NSObject

- (MKOverlayView*)viewForPolyline:(TKStyledPolyline*)polyline;

- (MKOverlayView*)viewForPolygon:(TKStyledPolygonArea*)polygon;

@end
