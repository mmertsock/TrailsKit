//
//  CLLocationManager+TrailsKit.m
//  TrailsKit
//
//  Created by Mike Mertsock on 9/19/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "CLLocationManager+TrailsKit.h"

@implementation CLLocationManager (TrailsKit)

+ (BOOL)tk_isAuthorizedWhenInUse
{
    CLAuthorizationStatus status = [self authorizationStatus];
    return TKIsAuthorizationStatusEnabledForInUse(status);
}

@end

BOOL TKIsAuthorizationStatusEnabledForInUse(CLAuthorizationStatus status)
{
    return status == kCLAuthorizationStatusAuthorizedAlways
        || status == kCLAuthorizationStatusAuthorizedWhenInUse;
}
