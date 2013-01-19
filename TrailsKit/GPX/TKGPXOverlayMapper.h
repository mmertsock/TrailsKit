//
//  TKGPXOverlayMapper.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/19/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPX;

@protocol TKGPXOverlayMapper <NSObject>

// On error, return nil. OK to return empty array.
- (NSArray*)mapOverlaysFromGPX:(GPX*)gpx;

@end
