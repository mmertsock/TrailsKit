//
//  TKPinAnnotation.h
//  RocTrails
//
//  Created by Mike Mertsock on 12/30/12.
//  Copyright (c) 2012 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TKPinAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;

+ (instancetype)pinAnnotationWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon title:(NSString*)aTitle;
+ (instancetype)majorFeatureWithCoordinate:(CLLocationCoordinate2D)coords title:(NSString*)aTitle;

@end
