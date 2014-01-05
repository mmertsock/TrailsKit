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

@interface TKAnnotationViewFactory ()
@property (nonatomic) NSMutableDictionary *viewBuilders;
@end

@implementation TKAnnotationViewFactory

- (id)init
{
    if (self = [super init]) {
        _viewBuilders = [NSMutableDictionary new];
    }
    return self;
}

- (void)setViewBuilder:(id<TKAnnotationViewBuilder>)builder
    forReuseIdentifier:(NSString *)reuseIdentifier
{
    _viewBuilders[reuseIdentifier] = builder;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(TKPointAnnotation *)annotation
              reuseIdentifier:(NSString *)reuseIdentifier
{
    id <TKAnnotationViewBuilder> viewBuilder = self.viewBuilders[reuseIdentifier];
    if (!viewBuilder) return nil;
    
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    if (!view) {
        view = [viewBuilder viewForAnnotation:annotation reuseIdentifier:reuseIdentifier];
    }
    
    [viewBuilder configureView:view withAnnotation:annotation];
    
    return view;
}

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
