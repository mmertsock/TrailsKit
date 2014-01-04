//
//  TKAnnotationViewFactory.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/27/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKAnnotationViewFactory.h"
#import "TrailsKitGeometry.h"
#import <MapKit/MapKit.h>

@implementation TKAnnotationViewFactory

- (MKAnnotationView*)reusableViewForAnnotation:(TKPointAnnotation*)annotation
                                withIdentifier:(NSString*)reuseIdentifier
                                    forMapView:(MKMapView*)mapView
                                  newViewBlock:(void (^)(MKAnnotationView*))newViewBlock
{
    MKAnnotationView* view = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    
    if (view) {
        view.annotation = annotation;
    } else {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                            reuseIdentifier:reuseIdentifier];
        newViewBlock(view);
    }
    
    return view;
}

@end
