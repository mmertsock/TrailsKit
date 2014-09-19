//
//  CLLocationManager+TrailsKit.h
//  TrailsKit
//
//  Created by Mike Mertsock on 9/19/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocationManager (TrailsKit)

+ (BOOL)tk_isAuthorizedWhenInUse;

@end

BOOL TKIsAuthorizationStatusEnabledForInUse(CLAuthorizationStatus status);
