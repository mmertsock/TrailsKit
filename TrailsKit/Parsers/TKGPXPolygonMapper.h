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

@class TKShapeStyle, TKVisibilityConstraint;

@interface TKGPXPolygonMapper : NSObject <TKGPXOverlayMapper>

@property (nonatomic, readonly) TKShapeStyle* shapeStyle;
@property (nonatomic, readonly) TKVisibilityConstraint *defaultVisibilityConstraint;
@property (nonatomic) BOOL treatMultipleTracksInFileAsInteriorPolygons;

- (id)initWithStyle:(TKShapeStyle*)aStyle
defaultVisibilityConstraint:(TKVisibilityConstraint *)constraint;

@end
