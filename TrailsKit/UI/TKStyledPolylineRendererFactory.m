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
    return [self rendererForPolyline:polyline shapeStyle:polyline.shapeStyle];
}

- (MKOverlayRenderer *)rendererForPolyline:(TKStyledPolyline *)polyline
                                shapeStyle:(TKShapeStyle *)shapeStyle
{
    MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithPolyline:polyline.overlay];
    [self setStyle:shapeStyle forPathRenderer:renderer];
    return renderer;
}

- (MKOverlayRenderer *)rendererForPolygon:(TKStyledPolygonArea *)polygon
{
    return [self rendererForPolygon:polygon shapeStyle:polygon.shapeStyle];
}

- (MKOverlayRenderer *)rendererForPolygon:(TKStyledPolygonArea *)polygon
                               shapeStyle:(TKShapeStyle *)shapeStyle
{
    MKPolygonRenderer* renderer = [[MKPolygonRenderer alloc] initWithPolygon:polygon.overlay];
    [self setStyle:shapeStyle forPathRenderer:renderer];
    return renderer;
}

- (void)setStyle:(TKShapeStyle *)shapeStyle
 forPathRenderer:(MKOverlayPathRenderer *)renderer
{
    renderer.strokeColor = shapeStyle.strokeColor;
    renderer.fillColor = shapeStyle.fillColor;
    renderer.lineWidth = shapeStyle.lineWidth;
    renderer.lineJoin = (shapeStyle.lineDashPattern.count > 0) ? kCGLineJoinMiter : kCGLineJoinRound;
    renderer.lineCap = (shapeStyle.lineDashPattern.count > 0) ? kCGLineCapButt : kCGLineCapRound;
    renderer.lineDashPattern = shapeStyle.lineDashPattern;
    renderer.lineDashPhase = shapeStyle.lineDashPhase;
}

@end
