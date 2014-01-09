//
//  TKGPXPolygonMapper.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/19/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrailsKitTypes.h"
#import "TKGPXOverlayMapper.h"

@class TKShapeStyle, TKVisibilityConstraints;

@interface TKGPXPolygonMapper : NSObject <TKGPXOverlayMapper>

@property (nonatomic, readonly) TKShapeStyle* shapeStyle;
@property (nonatomic, readonly) TKVisibilityConstraints *defaultVisibilityConstraints;

- (id)initWithStyle:(TKShapeStyle*)aStyle
defaultVisibilityConstraints:(TKVisibilityConstraints *)constraints;

@end
