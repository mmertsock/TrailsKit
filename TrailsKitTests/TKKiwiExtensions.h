//
//  TKKiwiExtensions.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/5/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <CoreLocation/CoreLocation.h>

#ifndef TrailsKit_TKKiwiExtensions_h
#define TrailsKit_TKKiwiExtensions_h

#define TKExpectCoordinate(subject, expectation) \
[[@(subject.latitude) should] equal:expectation.latitude withDelta:0.01]; \
[[@(subject.longitude) should] equal:expectation.longitude withDelta:0.01]

#define TKExpectLatitudeLongitude(subject, lat, lon) TKExpectCoordinate(subject, CLLocationCoordinate2DMake(lat, lon))

#endif
