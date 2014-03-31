//
//  GPX+TrailsKit.m
//  TrailsKit
//
//  Created by Mike Mertsock on 3/31/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "GPX+TrailsKit.h"

@implementation GPX (TrailsKit)

- (NSArray *)allTracks
{
    return [self.routes arrayByAddingObjectsFromArray:self.tracks];
}

@end
