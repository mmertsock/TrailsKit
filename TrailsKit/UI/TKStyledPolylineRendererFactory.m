//
//  TKStyledPolylineView.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/9/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKStyledPolylineRendererFactory.h"
#import <MapKit/MapKit.h>
#import "TrailsKitGeometry.h"

@interface TKStyledPolylineRendererFactory ()
- (void)setStyle:(TKShapeStyle *)shapeStyle
 forPathRenderer:(MKOverlayPathRenderer *)renderer;
@end

@implementation TKStyledPolylineRendererFactory

- (MKOverlayRenderer *)rendererForPolyline:(TKStyledPolyline *)polyline
{
    MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithPolyline:polyline.overlay];
    [self setStyle:polyline.shapeStyle forPathRenderer:renderer];
    return renderer;
}

- (MKOverlayRenderer *)rendererForPolygon:(TKStyledPolygonArea *)polygon
{
    MKPolygonRenderer* renderer = [[MKPolygonRenderer alloc] initWithPolygon:polygon.overlay];
    [self setStyle:polygon.shapeStyle forPathRenderer:renderer];
    return renderer;
}

- (void)setStyle:(TKShapeStyle *)shapeStyle
 forPathRenderer:(MKOverlayPathRenderer *)renderer
{
    renderer.strokeColor = shapeStyle.strokeColor;
    renderer.fillColor = shapeStyle.fillColor;
    renderer.lineWidth = shapeStyle.lineWidth;
    renderer.lineJoin = kCGLineJoinRound;
    renderer.lineCap = kCGLineCapRound;
}

@end
