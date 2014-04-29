//
//  TKGPXParser.h
//  
//
//  Created by Mike Mertsock on 1/18/13.
//
//

#import <Foundation/Foundation.h>
#import "TrailsKitTypes.h"

@protocol TKGPXOverlayMapper;

@interface TKGPXParser : NSObject

@property (nonatomic, readonly) id<TKGPXOverlayMapper> mapper;

- (id)initWithMapper:(id<TKGPXOverlayMapper>)aMapper;

// Callback invoked on the main thread
- (void)parseData:(NSData*)gpxData
       completion:(TKOverlayCompletionHandler)completionHandler;

@end
