//
//  TrailsKitTypes.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/18/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#ifndef TrailsKit_TrailsKitTypes_h
#define TrailsKit_TrailsKitTypes_h

#import <CoreLocation/CoreLocation.h>

typedef CLLocationDistance TKMapScale;

typedef void (^TKOverlayCompletionHandler)(BOOL success, NSArray* overlays);

#endif
