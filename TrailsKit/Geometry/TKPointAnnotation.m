//
//  TKPointAnnotation.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/2/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "TKPointAnnotation.h"

@implementation TKPointAnnotation

- (id)initWithLatitude:(CLLocationDegrees)lat
             longitude:(CLLocationDegrees)lon
                 title:(NSString *)aTitle
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(lat, lon)
                              title:aTitle
                               data:nil
                              style:nil];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coords
                   title:(NSString *)aTitle
                    data:(id)data
                   style:(TKShapeStyle *)style
{
    if (self = [super init]) {
        self.coordinate = coords;
        self.title = aTitle;
        self.subtitle = nil;
        _data = data;
        _style = style;
    }
    return self;
}

@end
