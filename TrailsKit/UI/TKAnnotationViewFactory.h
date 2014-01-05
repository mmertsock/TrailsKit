//
//  TKAnnotationViewFactory.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/27/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKPointAnnotation, MKAnnotationView, MKMapView;

@protocol TKAnnotationViewBuilder <NSObject>
- (MKAnnotationView *)viewForAnnotation:(TKPointAnnotation *)annotation
                        reuseIdentifier:(NSString *)reuseIdentifier;
- (void)configureView:(MKAnnotationView *)view
       withAnnotation:(TKPointAnnotation *)annotation;
@end

@interface TKAnnotationViewFactory : NSObject

- (void)setViewBuilder:(id<TKAnnotationViewBuilder>)builder
    forReuseIdentifier:(NSString *)reuseIdentifier;

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(TKPointAnnotation*)annotation
              reuseIdentifier:(NSString *)reuseIdentifier;

- (MKAnnotationView*)reusableViewForAnnotation:(TKPointAnnotation*)annotation
                                withIdentifier:(NSString*)reuseIdentifier
                                    forMapView:(MKMapView*)mapView
                                  newViewBlock:(void (^)(MKAnnotationView*))newViewBlock;

@end
