//
//  TKPinAnnotationViewFactory.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/27/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKPinAnnotation, MKAnnotationView, MKMapView;

@interface TKPinAnnotationViewFactory : NSObject

- (MKAnnotationView*)reusableViewForAnnotation:(TKPinAnnotation*)annotation
                                withIdentifier:(NSString*)reuseIdentifier
                                    forMapView:(MKMapView*)mapView
                                  newViewBlock:(void (^)(MKAnnotationView*))newViewBlock;

@end
