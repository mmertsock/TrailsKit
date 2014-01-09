//
//  TKShapeStyle.m
//  GPXTest
//
//  Created by Mike Mertsock on 1/6/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import "TKShapeStyle.h"

@implementation TKShapeStyle

- (id)initWithStrokeColor:(UIColor *)strokeColor
                lineWidth:(CGFloat)lineWidth
                fillColor:(UIColor *)fillColor
             overlayLevel:(MKOverlayLevel)overlayLevel
{
    if (self = [super init]) {
        _strokeColor = strokeColor;
        _lineWidth = lineWidth;
        _fillColor = fillColor;
        _overlayLevel = overlayLevel;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<TKShapeStyle stroke:%@ fill:%@ lineWidth:%f level:%d>",
            self.strokeColor, self.fillColor, self.lineWidth, self.overlayLevel];
}

@end
