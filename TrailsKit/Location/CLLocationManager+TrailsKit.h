//
//  CLLocationManager+TrailsKit.h
//  TrailsKit
//
//  Created by Mike Mertsock on 9/19/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocationManager (TrailsKit)

+ (BOOL)tk_authorizationRequestsEnabled;
+ (BOOL)tk_isOrCanBeAuthorizedWhenInUse;

@property (readonly) BOOL tk_mustAskForAuthorization;

@end

// iOS 8: app has already asked for authorization and user has granted it.
// iOS 7: user has granted or will be asked on next usage of location services (authorization is asked automatically).
// In both cases, returns NO if authorization is denied or restricted.
BOOL TKAuthorizationStatusIsOrCanBeEnabledForInUse(CLAuthorizationStatus status);
