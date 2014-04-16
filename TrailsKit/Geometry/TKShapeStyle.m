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
          lineDashPattern:(NSArray *)lineDashPattern
            lineDashPhase:(CGFloat)lineDashPhase
{
    if (self = [super init]) {
        _strokeColor = strokeColor;
        _lineWidth = lineWidth;
        _fillColor = fillColor;
        _overlayLevel = overlayLevel;
        _lineDashPattern = lineDashPattern;
        _lineDashPhase = lineDashPhase;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<TKShapeStyle stroke:%@ fill:%@ lineWidth:%f level:%@ dash:%@/%f>",
            self.strokeColor, self.fillColor, self.lineWidth,
            @(self.overlayLevel), self.lineDashPattern, self.lineDashPhase];
}

@end
