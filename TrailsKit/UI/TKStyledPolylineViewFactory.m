//
//  TKStyledPolylineView.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/9/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKStyledPolylineViewFactory.h"
#import <MapKit/MapKit.h>
#import "TrailsKitGeometry.h"

@interface TKStyledPolylineViewFactory ()
- (void)setStyle:(TKShapeStyle*)shapeStyle
     forPathView:(MKOverlayPathView*)view;
@end

@implementation TKStyledPolylineViewFactory

- (MKOverlayView*)viewForPolyline:(TKStyledPolyline *)polyline
{
    MKPolylineView* view = [[MKPolylineView alloc] initWithPolyline:polyline.overlay];
    [self setStyle:polyline.shapeStyle forPathView:view];
    return view;
}

- (MKOverlayView *)viewForPolygon:(TKStyledPolygonArea *)polygon
{
    MKPolygonView* view = [[MKPolygonView alloc] initWithPolygon:polygon.overlay];
    [self setStyle:polygon.shapeStyle forPathView:view];
    return view;
}

- (void)setStyle:(TKShapeStyle *)shapeStyle
     forPathView:(MKOverlayPathView *)view
{
    view.strokeColor = shapeStyle.strokeColor;
    view.fillColor = shapeStyle.fillColor;
    view.lineWidth = shapeStyle.lineWidth;
    view.lineJoin = kCGLineJoinRound;
    view.lineCap = kCGLineCapRound;
}

@end
