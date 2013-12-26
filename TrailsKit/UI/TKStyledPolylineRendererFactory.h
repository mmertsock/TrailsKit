//
//  TKStyledPolylineView.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/9/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKStyledPolyline, TKStyledPolygonArea, MKOverlayRenderer;

@interface TKStyledPolylineRendererFactory : NSObject

- (MKOverlayRenderer *)rendererForPolyline:(TKStyledPolyline *)polyline;

- (MKOverlayRenderer *)rendererForPolygon:(TKStyledPolygonArea*)polygon;

@end
