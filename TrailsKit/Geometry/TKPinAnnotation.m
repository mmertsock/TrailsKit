//
//  TKPinAnnotation.m
//  RocTrails
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import "TKPinAnnotation.h"

@implementation TKPinAnnotation
- (id)initWithCoords:(CLLocationCoordinate2D)coords title:(NSString *)aTitle
{
    if (self = [super init]) {
        self.coordinate = coords;
        self.title = aTitle;
    }
    return self;
}
+ (instancetype)pinAnnotationWithCoordinate:(CLLocationCoordinate2D)coords title:(NSString *)aTitle
{
    return [[TKPinAnnotation alloc] initWithCoords:coords title:aTitle];
}
+ (instancetype)pinAnnotationWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon title:(NSString *)aTitle
{
    return [self pinAnnotationWithCoordinate:CLLocationCoordinate2DMake(lat, lon) title:aTitle];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"<PinAnnotation %@ @ (%f,%f)",
            self.title, self.coordinate.latitude, self.coordinate.longitude];
}

@end
