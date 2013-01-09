//
//  TKStyledPolylineView.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/9/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKStyledPolylineView.h"
#import <MapKit/MapKit.h>
#import "TKStyledPolyline.h"
#import "TKShapeStyle.h"

@implementation TKStyledPolylineView

- (MKOverlayView*)viewForPolyline:(TKStyledPolyline *)polyline
{
    MKPolylineView* view = [[MKPolylineView alloc] initWithPolyline:polyline.overlay];
    view.strokeColor = polyline.shapeStyle.strokeColor;
    view.lineWidth = polyline.shapeStyle.lineWidth;
    view.lineJoin = kCGLineJoinRound;
    view.lineCap = kCGLineCapRound;
    return view;
}

@end
