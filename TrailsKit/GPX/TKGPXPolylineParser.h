//
//  TKGPXPolylineParser.h
//  GPXTest
//
//  Created by Mike Mertsock on 1/6/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKShapeStyle;

@interface TKGPXPolylineParser : NSObject

@property (nonatomic, strong) TKShapeStyle* shapeStyle;

- (void)parseData:(NSData*)gpxData
       completion:(void(^)(BOOL, NSArray*))completionHandler;

@end
