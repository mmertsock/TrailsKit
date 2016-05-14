//
//  GPX+TrailsKit.h
//  TrailsKit
//
//  Created by Mike Mertsock on 3/31/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <GPXParser/GPXParser.h>

@interface GPX (TrailsKit)
@property (nonatomic, readonly) NSArray *allTracks; // routes and tracks combined
@end
