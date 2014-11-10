//
//  CLLocationManager+TrailsKit.m
//  TrailsKit
//
//  Created by Mike Mertsock on 9/19/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "CLLocationManager+TrailsKit.h"

@implementation CLLocationManager (TrailsKit)

+ (BOOL)tk_authorizationRequestsEnabled
{
    return [self instancesRespondToSelector:@selector(requestWhenInUseAuthorization)];
}

- (BOOL)tk_mustAskForAuthorization
{
    return [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined
    && [CLLocationManager tk_authorizationRequestsEnabled];
}

+ (BOOL)tk_isOrCanBeAuthorizedWhenInUse
{
    CLAuthorizationStatus status = [self authorizationStatus];
    return TKAuthorizationStatusIsOrCanBeEnabledForInUse(status);
}

@end

BOOL TKAuthorizationStatusIsOrCanBeEnabledForInUse(CLAuthorizationStatus status)
{
    if ([CLLocationManager tk_authorizationRequestsEnabled])
        return status == kCLAuthorizationStatusAuthorizedAlways
        || status == kCLAuthorizationStatusAuthorizedWhenInUse;
    else
        return status != kCLAuthorizationStatusDenied
        && status != kCLAuthorizationStatusRestricted;
}
